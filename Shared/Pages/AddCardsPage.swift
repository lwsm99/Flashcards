//
//  AddCardsPage.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 21.06.22.
//

import Foundation
import SwiftUI

struct AddCardsPage: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    // UI Variables
    @State var cardPosition: CGFloat = 0
    let smallButtonSize: CGFloat = 40
    @State private var bgColor = Color.error
    @State var draggeddIndex = 0
    
    // Card Variables
    @State private var cardFront = ""
    @State private var cardBack = ""
    @State private var deckOfCard:[Deck] = []
    
    // Deck Variables
    @State private var deckTitle = ""
    @State private var deckColor = UIColor.blue // TODO: Change Defaultcolor
    @State private var cardsOfDeck:[Card] = []
    
    var body: some View {
        VStack {
            HStack {
                // Input for deck title
                TextField("Deck Titel", text: $deckTitle).frame(height: 47)
                    .padding([.leading, .trailing], 15)
                    .background(Color.white, in: Capsule())
                
                ColorPicker("", selection: $bgColor).labelsHidden().scaleEffect(CGSize(width: 1.6, height: 1.6)).padding([.leading, .trailing], 15)
            }.padding(.bottom, 20)
            
                ForEach(
                    0...0,
                    id: \.self
                ) {
                    card in
                        // Card
                        VStack {
                            TextField("Begriff", text: $cardFront).frame(height: 65)
                                .padding([.leading, .trailing], 15)
                                .background(Color.white)
                                .cornerRadius(8)
                            TextField("Definition", text: $cardBack).frame(height: 400)
                                .padding([.leading, .trailing], 15)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color.uncreatedCardColor)
                        .offset(x: getOffset(index: card))
                }.padding(.bottom, 10)
            
            Button(action: {
                print("Save")
                addDeck()
                addCard()
            }){
                Image(systemName: "plus").font(.system(size: 20)).foregroundColor(Color.primary).frame(width: smallButtonSize, height: smallButtonSize).background(Color.white).cornerRadius(smallButtonSize/2)
            }
            
            Spacer()
        }
        .padding([.leading, .trailing], 15)
        .frame(maxHeight: .infinity)
        .background(Color.background)
        .ignoresSafeArea(.keyboard)
    }
    
    
    func getOffset(index: Int) -> CGFloat {
        return index == draggeddIndex ? cardPosition : 0
    }
    
    func onEnd(value: DragGesture.Value) {
        if(value.translation.width > 0) {
            cardPosition = 0
        }
    }
    
    private func addDeck() {
        let deck = Deck(context: viewContext)
        
        // Initialize Data
        deck.id = UUID()
        deck.title = deckTitle
        deck.color = deckColor
        
        // Assign Cards to deck
        let uniqueCard = Set(cardsOfDeck)
        for card in uniqueCard {
            deck.addToDeckToCard(card)
        }
        
        // Try saving
        try? viewContext.save()
    }
    
    private func addCard() {
        let card = Card(context: viewContext)
        
        // Initialize Data
        card.id = UUID()
        card.createdAt = Date()
        card.box = 0
        card.passedCount = 0
        card.failedCount = 0
        
        // Set Front/Back of the card to the value assigned in the view
        card.front = cardFront
        card.back = cardBack
        
        // Set Deck for the card
        card.cardToDeck = deckOfCard.first
        
        // Try saving
        try? viewContext.save()
    }
}
