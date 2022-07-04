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
    // Card Amount for each deck
    
    
    var body: some View {
        VStack {
            
            // Input
            SearchInput()
            
            Spacer().frame(height:30)
            
            // Decks 
            ScrollView {
                VStack{
                    ForEach(deckList) { deck in
                        NavigationLink(destination: DeckCardMenu(title: deck.title!, cardCount: getCardCount(deck: deck), progress: 67, color: $bgColor1, deck: deck)) {
                            DeckCard(color: $bgColor1, title: deck.title!, subtitle: "10 Karten", progress: 67)
                        }
                    }
                }.navigationTitle("Alle Decks")
            }
            
        }
        .background(Color.background)
    }
    
    func getCardCount(deck: Deck) -> Int {
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], predicate: NSPredicate(format: "cardToDeck == %@", deck), animation: .default) var cardList: FetchedResults<Card>
        return cardList.count
    }
}
