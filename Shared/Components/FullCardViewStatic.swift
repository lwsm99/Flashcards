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
    
    // Variables
    var cardList: FetchedResults<Card>
    var currCard: Int
    let showButtons: Bool
    @State private var showFront: Bool = true
    @State private var showFlip: Bool = true
    var body: some View {
        VStack {
            Color.background
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Text("\(cardList[currCard].cardToDeck!.title!)")
                            .bold()
                            .font(.title)
                        Spacer().frame(height: 60)
                        Button(action: {showFront = !showFront}) {
                            Text(showFront ? "\(cardList[currCard].front!)" : "\(cardList[currCard].back!)" )
                                .frame(width: 300, height: 350)
                                .padding()
                                .foregroundColor(.black)
                        }.background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        if(showButtons) {
                            Spacer().frame(height: 30)
                            HStack {
                                if(showFlip) {
                                    Button(action: {showFlip = !showFlip}) {
                                        Text("Flip card")
                                            .frame(width: 300, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                    }
                                }
                                else {
                                    Button {
                                        updateCard(card: cardList[currCard], difficulty: AGAIN)
                                    } label: {
                                        Text("♻️")
                                    }.frame(width: 60, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                    Spacer().frame(width: 30)
                                    Button {
                                        updateCard(card: cardList[currCard], difficulty: HARD)
                                    } label: {
                                        Text("😐")
                                    }.frame(width: 60, height: 60)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                    Spacer().frame(width: 30)
                                    Button {
                                        updateCard(card: cardList[currCard], difficulty: GOOD)
                                    } label: {
                                        Text("🙂")
                                    }.frame(width: 60, height: 60)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                    Spacer().frame(width: 30)
                                    Button {
                                        updateCard(card: cardList[currCard], difficulty: EASY)
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
                )
        }
    }
    
    func updateCard(card: Card, difficulty: Int) {
        
        // Set box & counters according to answer
        if(difficulty == AGAIN) {
            card.box = 0
            card.failedCount += 1
        }
        if(difficulty == HARD) {
            card.box -= 1
            card.passedCount += 1
        }
        if(difficulty == GOOD) {
            card.box += 1
            card.passedCount += 1
        }
        if(difficulty == EASY) {
            card.box += 1.5
            card.passedCount += 1
        }
            
        card.lastReviewed = Date()
        
        // Calculate next Review
        var reviewIntervall: Double = 3
        for _ in 2...Int(floor(card.box)) {
            reviewIntervall = reviewIntervall * REVIEW_INTERVALL_MULTIPLIER
        }
        
        var dateComponent = DateComponents()
        dateComponent.day = Int(round(ceil(reviewIntervall)))
        card.nextReview = Calendar.current.date(byAdding: dateComponent, to: card.lastReviewed!)
        
        // Try saving
        do {
            try viewContext.save()
            print("Saving success")
        } catch {
            print("Unexpected error: \(error.localizedDescription).")
        }
    }
}
