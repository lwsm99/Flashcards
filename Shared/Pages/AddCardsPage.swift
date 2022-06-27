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
    
    // Card Variables
    @State private var cardFront = ""
    @State private var cardBack = ""
    @State private var deckOfCard:[Deck] = []
    
    // Deck Variables
    @State private var deckTitle = ""
    @State private var deckColor = UIColor.blue // TODO: Change Defaultcolor
    @State private var cardsOfDeck:[Card] = []
    
    var body: some View {
        Text("TODO: Add AddCardsPage")
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
