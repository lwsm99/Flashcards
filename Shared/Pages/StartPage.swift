//
//  StartPage.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 20.06.22.
//

import Foundation
import SwiftUI

struct StartPage: View {
    @State private var inputValue: String = ""
    @State private var bgColor1 = Color.statisticsPrimary
    @State private var bgColor2 = Color.statisticsSecondary
    @State private var bgColor3 = Color.statisticsTertiary
    @State private var bgColor = Color.error
    
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    // All Decks
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Deck.title, ascending: true)], animation: .default) private var deckList: FetchedResults<Deck>
    // All Cards
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], animation: .default) private var cardList: FetchedResults<Card>
    
    
    var body: some View {
        VStack {
            
            // Input
            SearchInput()
            
            Spacer().frame(height:30)
            
            // Decks 
            ScrollView {
                VStack{
                    ForEach(deckList) { deck in
                        NavigationLink(destination: DeckCardMenu(title: deck.title ?? "", cardCount: getCardCount(deck: deck), progress: getProgress(deck: deck), color: $bgColor1, deck: deck)) {
                            DeckCard(color: $bgColor1, title: deck.title ?? "", subtitle: "\(getCardCount(deck: deck)) Karte(n)", progress: getProgress(deck: deck))
                        }.simultaneousGesture(TapGesture().onEnded { DeckSettings.value = deck })
                    }
                }.navigationTitle("Alle Decks")
            }
        }
        .background(Color.background)
    }
    
    private func getProgress(deck: Deck) -> Double {
        var learnedCount: Int = 0
        var cardCount: Int = 0
        
        for card in cardList {
            if(card.cardToDeck == deck) {
                if(card.box != 0) {
                    learnedCount += 1
                }
                cardCount += 1
            }
        }
        return Double(Double(learnedCount) / Double(cardCount))
    }
    
    private func getCardCount(deck: Deck) -> Int {
        var cardCnt = 0
        
        for card in cardList {
            if(card.cardToDeck == deck) {
                cardCnt += 1
            }
        }
        return cardCnt
    }
}
