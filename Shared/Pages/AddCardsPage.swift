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
    
    @State private var cardFront = ""
    @State private var cardBack = ""
    @State private var selectedDecks:[Deck] = []
    
    // Fetche alle vorhandenen Decks
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Deck.title, ascending: true)], animation: .default) private var deckList: FetchedResults<Deck>
    
    var body: some View {
        Text("TODO: Add AddCardsPage")
        
        // TODO: Mit ForEach(deckList) alle Decks aus DB anzeigen (momentan noch leer)
        // TODO: Um eine Karte direkt zu Deck(s) hinzuzufügen brauchen wir dann eine Deck Auswahl und du würdest dann die ausgewählten Decks 'selectedDecks' hinzufügen, diese werden dann bei addCard automatisch berücksichtigt
        
        // TODO: cardFront & cardBack je nach Usereingabe setzen
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
        
        // Set Decks for the card assigned in the view
        let uniqueDeck = Set(selectedDecks)
        for deck in uniqueDeck {
            card.addToCardToDeck(deck)
        }
        
        // Try saving
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
