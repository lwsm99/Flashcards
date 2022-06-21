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
    
    var body: some View {
        VStack {
            
            // Input
            HStack {
                Spacer().frame(width:15)
                HStack {
                    TextField("Name der Ordner eingeben", text: $inputValue)
                    Image(systemName: "magnifyingglass").foregroundColor(Color.disabled)
                }.frame(height: 47)
                    .padding([.leading, .trailing], 15)
                    .background(Color.white, in: Capsule())
                Spacer().frame(width:15)
            }
            
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
