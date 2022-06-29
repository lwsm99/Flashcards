//
//  AddCardsPage.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 21.06.22.
//

import Foundation
import SwiftUI

struct AddCardsPage: View {
    
    @State var cardPosition: CGFloat = 0
    let smallButtonSize: CGFloat = 40
    @State private var inputValue: String = ""
    @State private var bgColor = Color.error
    @State var draggeddIndex = 0
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
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
                // Input for deck name
                TextField("Deck name", text: $inputValue).frame(height: 47)
                    .padding([.leading, .trailing], 15)
                    .background(Color.white, in: Capsule())
                
                
                ColorPicker("", selection: $bgColor).labelsHidden().scaleEffect(CGSize(width: 1.6, height: 1.6)).padding([.leading, .trailing], 15)
            }.padding(.bottom, 20)
            
            ScrollView {
                ForEach(
                    0...1,
                    id: \.self
                ) {
                    card in
                    ZStack(alignment: .trailing) {
                        
                        // Delete button
                        Button(action: {}) {
                            Image(systemName: "trash").font(.system(size: 26)).foregroundColor(Color.white).frame(width: smallButtonSize, height: smallButtonSize).background(Color.error).cornerRadius(smallButtonSize/2)
                        }.padding(.trailing, 10)
                        
                        // Card
                        VStack {
                            TextField("Begriff", text: $inputValue).frame(height: 40)
                                .padding([.leading, .trailing], 15)
                                .background(Color.white, in: Capsule())
                            TextField("Definition", text: $inputValue).frame(height: 40)
                                .padding([.leading, .trailing], 15)
                                .background(Color.white, in: Capsule())
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color.uncreatedCardColor)
                        .cornerRadius(20)
                        .offset(x: getOffset(index: card))
                        .gesture(DragGesture()
                            .onChanged({
                                value in
                                draggeddIndex = card
                                if(value.translation.width < 0) {
                                    cardPosition = -90
                                }
                            })
                            .onEnded(onEnd(value:)))
                        .animation(.spring(), value: getOffset(index: card))
                    }
                    
                    
                }
            }.padding(.bottom, 10)
            
            Button(action: {}){
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
        try! viewContext.save()
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
        try! viewContext.save()
    }
}
