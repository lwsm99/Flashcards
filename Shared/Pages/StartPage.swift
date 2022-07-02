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
    
    // Fetch all available Decks
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Deck.title, ascending: true)], animation: .default) private var deckList: FetchedResults<Deck>
    
    var body: some View {
        VStack {
            
            // Input
            SearchInput()
            
            Spacer().frame(height:30)
            
            // Decks 
            ScrollView {
                VStack{
                    NavigationLink(destination: DeckCardMenu(title: "Spanisch", cardCount: 10, progress: 67, color: $bgColor1)) {
                        DeckCard(color: $bgColor1, title: "Spanisch", subtitle: "10 Karten", progress: 67)
                    }
                    NavigationLink(destination: DeckCardMenu(title: "Englisch", cardCount: 27, progress: 92, color: $bgColor2)) {
                        DeckCard(color: $bgColor2, title: "Englisch", subtitle: "27 Karten", progress: 92)
                    }
                    NavigationLink(destination: DeckCardMenu(title: "Japanisch", cardCount: 13, progress: 24, color: $bgColor3)) {
                        DeckCard(color: $bgColor3, title: "Japanisch", subtitle: "13 Karten", progress: 24)
                    }
                }.navigationTitle("Alle Decks")
            }
            
        }
        .background(Color.background)
    }
}
