//
//  FullCardView.swift
//  Flashcards (iOS)
//
//  Created by II on 02.07.22.
//

import SwiftUI
import Foundation

// Macros
let AGAIN = 0
let HARD = 1
let GOOD = 2
let EASY = 3
let REVIEW_INTERVALL_MULTIPLIER = 2.05

struct FullCardViewStatic: View {
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    // Parameter Variables
    var cardList: FetchedResults<Card>
    @State var currCard: Int = 0
    let showButtons: Bool
    
    // Private Variables
    @State private var cardArray: [Card] = []
    @State private var passedAmount: Int = 0
    @State private var failedAmount: Int = 0
    @State private var showFront: Bool = true
    @State private var showFlip: Bool = true
    @State private var finishedLearning: Bool = false
    
    var body: some View {
        VStack {
            Color.background
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        if(!finishedLearning) {
                            Text("\(cardList[currCard].cardToDeck!.title ?? "Missing title!")")
                                .bold()
                                .font(.title)
                            Spacer().frame(height: 60)
                            Button(action: {}) {
                                Text(showFront ? "\(cardList[currCard].front ?? "")" : "\(cardList[currCard].back ?? "")" )
                                    .frame(width: 300, height: 350)
                                    .padding()
                                    .foregroundColor(.black)
                            }.background(RoundedRectangle(cornerRadius: 10).fill(.white))
                            if(showButtons) {
                                Spacer().frame(height: 30)
                                HStack {
                                    if(showFlip) {
                                        Button(action: {
                                            showFlip = !showFlip
                                            showFront = false
                                        }) {
                                            Text("Flip card")
                                                .frame(width: 300, height: 60)
                                                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                        }
                                    }
                                    else {
                                        
                                        // TODO: Link to this page via LearnCardsPage
                                        // TODO: Only give cardList of selected Decks in LearnCardsPage
                                        
                                        // TODO: First show "Front" with "Flip Card", when flipping show Solution + Answer Buttons
                                        // TODO: After Review, switch to next card (Almost works, need to show finish screen when currCard == cardArray.count)
                                        // TODO: Initialize Card Array and use that instead of cardList, so we can append
                                        
                                        // TODO: Display Progress(bar?) (currCard/cardArray.count)
                                        // TODO: Display Progress (failedAmount & passedAmount)
                                        
                                        Button {
                                            //if(currCard == 1) { initArray() }
                                            //updateCard(card: cardArray[currCard], difficulty: AGAIN)
                                            updateCard(card: cardList[currCard], difficulty: AGAIN)
                                        } label: {
                                            Text("♻️")
                                        }.frame(width: 60, height: 60)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                        Spacer().frame(width: 30)
                                        Button {
                                            //if(currCard == 1) { initArray() }
                                            //updateCard(card: cardArray[currCard], difficulty: HARD)
                                            updateCard(card: cardList[currCard], difficulty: AGAIN)
                                        } label: {
                                            Text("😐")
                                        }.frame(width: 60, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                        Spacer().frame(width: 30)
                                        Button {
                                            //if(currCard == 1) { initArray() }
                                            //updateCard(card: cardArray[currCard], difficulty: GOOD)
                                            updateCard(card: cardList[currCard], difficulty: AGAIN)
                                        } label: {
                                            Text("🙂")
                                        }.frame(width: 60, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                        Spacer().frame(width: 30)
                                        Button {
                                            //if(currCard == 1) { initArray() }
                                            //updateCard(card: cardList[currCard], difficulty: EASY)
                                            updateCard(card: cardList[currCard], difficulty: AGAIN)
                                        } label: {
                                            Text("😄")
                                        }.frame(width: 60, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                    }
                                    
                                }
                                Spacer().frame(height: 40)
                            }
                            if(!showButtons) {
                                Spacer().frame(height: 40)
                                Button(action: {showFlip = !showFlip; showFront = !showFront}) {
                                    Text(showFlip ? "Show back" : "Show front")
                                        .frame(width: 330, height: 60)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                }
                                Spacer().frame(height: 100)
                            }
                            
                        }
                        else {
                            Button(action: {dismiss()}) {
                                Text("Super, alles gelernt!")
                            }
                        }
                    }
                )
        }
    }
    
    func initArray() {
        for card in cardList {
            cardArray.append(card)
        }
    }
    
    func updateCard(card: Card, difficulty: Int) {
        
        // Set box & counters according to answer
        if(difficulty == AGAIN) {
            card.box = 0
            card.failedCount += 1
            failedAmount += 1
            cardArray.append(card)
        }
        if(difficulty == HARD) {
            if(card.box == 0) { card.box += 1 }
            else { card.box -= 1 }
            card.failedCount += 1
            failedAmount += 1
        }
        if(difficulty == GOOD) {
            card.box += 1
            card.passedCount += 1
            passedAmount += 1
        }
        if(difficulty == EASY) {
            card.box += 1.5
            card.passedCount += 1
            passedAmount += 1
        }
            
        card.lastReviewed = Date()
        
        // Calculate next Review
        var reviewIntervall: Double = 3
        if (card.box >= 2) {
            for _ in 2...Int(floor(card.box)) {
                reviewIntervall = reviewIntervall * REVIEW_INTERVALL_MULTIPLIER
            }
        }
        
        var dateComponent = DateComponents()
        dateComponent.day = Int(round(ceil(reviewIntervall)))
        card.nextReview = Calendar.current.date(byAdding: dateComponent, to: card.lastReviewed!)
        
        // Try saving
        do {
            try viewContext.save()
            print("Saving success")
            //print("Box: \(card.box)")
        } catch {
            print("Unexpected error: \(error.localizedDescription).")
        }
        
        // Next card
        print(cardList.count)
        print(currCard)
        if(currCard < (cardList.count - 1)) {
            currCard += 1
            showFlip = true
            showFront = true
        } else {
            finishedLearning = true
        }
    }
}
