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
                    ForEach(
                                1...100,
                                id: \.self
                            ) {
                                number in
                                DeckCard(color: $bgColor, title: "Spanisch", subtitle: "10 Karten", progress: 80)
                            }
                }
            }
            
        }
        .background(Color.background)
    }
}
