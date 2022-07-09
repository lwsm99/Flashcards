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

struct deckListItem: View {
     var deckName: String
     var cardCount: Int
     var body: some View {
         if(cardCount > 0) {
             HStack {
                 Text(deckName ?? "No deck name!")
                 Spacer()
                 Text("\(cardCount)")
             }
             .contentShape(Rectangle())
         } 
     }
 }

struct FullCardViewStatic: View {
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    // Parameter Variables
    @State var cardArray: [[Card]]
    @State var currCard: Int = 0
    let deckSet: Set<Deck>?
    let showButtons: Bool
    let freeLearn: Bool
    
    // Private Variables
    @State private var currDeck: Int = 0
    @State private var passedAmount: Int = 0
    @State private var failedAmount: Int = 0
    @State private var showFront: Bool = true
    @State private var showFlip: Bool = true
    @State private var finishedLearning: Bool = false
    @State private var startPage: Bool = true
    
    var body: some View {
        VStack {
            Color.background
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        
                        if(startPage) {
                            Text("Review-Modus")
                                .font(.title)
                                .bold()
                                .padding()
                            List {
                                ForEach(Array(deckSet!.enumerated()), id: \.offset) {
                                    index, deck in
                                    deckListItem(deckName: deck.title!, cardCount: cardArray[index].count)
                                }
                            }.padding([.top, .bottom])
                            Spacer().frame(height: 100)
                            Button(action: {startPage = !startPage}) {
                                Text("Jetzt ").foregroundColor(Color.primary)
                                + Text("\(cardArray.flatMap { $0 }.count)").foregroundColor(Color.error)
                                + Text(" Karten lernen!").foregroundColor(Color.primary)
                            }.padding([.bottom, .top], 20)
                                .font(.title2)
                        } else {
                            
                            if(!finishedLearning) {
                                Text("\(cardArray[currDeck][currCard].cardToDeck!.title ?? "Missing title!")")
                                    .bold()
                                    .font(.title)
                                ProgressView("", value: getCurrCard(), total: getCardCount()).accentColor(.red)
                                    .frame(width: 310)
                                    .padding()
                                Button(action: {}) {
                                    Text(showFront ? "\(cardArray[currDeck][currCard].front ?? "")" : "\(cardArray[currDeck][currCard].back ?? "")" )
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
                                                updateCard(card: cardArray[currDeck][currCard], difficulty: AGAIN)
                                            } label: {
                                                Text("♻️")
                                            }.frame(width: 60, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                            Spacer().frame(width: 30)
                                            Button {
                                                updateCard(card: cardArray[currDeck][currCard], difficulty: HARD)
                                            } label: {
                                                Text("😐")
                                            }.frame(width: 60, height: 60)
                                                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                            Spacer().frame(width: 30)
                                            Button {
                                                updateCard(card: cardArray[currDeck][currCard], difficulty: GOOD)
                                            } label: {
                                                Text("🙂")
                                            }.frame(width: 60, height: 60)
                                                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                            Spacer().frame(width: 30)
                                            Button {
                                                updateCard(card: cardArray[currDeck][currCard], difficulty: EASY)
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
                    }
                )
        }
    }
    
    func getCardCount() -> Double {
        var count: Double = Double(0)
        for (idx, _) in deckSet!.enumerated() {
            count += Double(cardArray[idx].count)
        }
        return count
    }
    
    func getCurrCard() -> Double {
        var currentCard: Double = Double(currCard)
        for (idx, _) in deckSet!.enumerated() {
            if(idx < currDeck) {
                currentCard += Double(cardArray[idx].count)
            }
        }
        return currentCard
    }
    
    func updateCard(card: Card, difficulty: Int) {
        if(freeLearn) {
            if(difficulty == AGAIN) {
                cardArray[currDeck].append(card)
            }
            if(currCard < (cardArray[currDeck].count - 1)) {
                print(cardArray[currDeck].count - 1)
                currCard += 1
                showFlip = true
                showFront = true
            } else {
                if(currDeck < (cardArray.count - 1)) {
                    print(cardArray.count - 1)
                    currDeck += 1
                    currCard = 0
                    showFlip = true
                    showFront = true
                }
                else {
                    finishedLearning = true
                    currDeck = 0
                }
            }
            return
        }
        // Set box & counters according to answer
        if(difficulty == AGAIN) {
            card.box = 0
            card.failedCount += 1
            failedAmount += 1
            cardArray[currDeck].append(card)
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
        if(currCard < (cardArray[currDeck].count - 1)) {
            print(cardArray[currDeck].count - 1)
            currCard += 1
            showFlip = true
            showFront = true
        } else {
            if(currDeck < (cardArray.count - 1)) {
                print(cardArray.count - 1)
                currDeck += 1
                currCard = 0
                showFlip = true
                showFront = true
            }
            else {
                finishedLearning = true
                currDeck = 0
            }
        }
    }
}
