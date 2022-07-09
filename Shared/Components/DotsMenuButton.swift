//
//  DotsMenuButton.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 21.06.22.
//

import Foundation
import SwiftUI
import MessageUI


struct DotsMenuButton: View {
    let itemToDelete: Deck?
    @State private var showAlert = false
    @State var didError = false
        
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], animation: .default) var cardList: FetchedResults<Card>
    
    var body: some View {
        ZStack {
            Menu {
                Section {
                    if(itemToDelete != nil) {
                        Button(action: {deleteDeck()}) {
                            Label("Deck löschen", systemImage: "trash")
                        }
                    }
                    
                    
                    Button(action: {didError = true}) {
                        Label("Feedback", systemImage: "bubble.middle.bottom")
                    }
                    
                    Button(action: {showAlert = true}) {
                        Label("Kontakt", systemImage: "person")
                    }
                    
                    Button(action: {}) {
                        Label("Impressum", systemImage: "doc")
                    }
                }
            }
            label: {
                Label("More", systemImage: "ellipsis").foregroundColor(Color.primary)
            }
        }.alert("E-mail für Feedback: luiza.shishina@mni.thm.de", isPresented: $didError) {
            Button("Zurück") {}
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Technische Hochschule Mittelhessen University of Applied Sciences"), message: Text("Wiesenstraße 14 D - 35390 Gießen info@thm.de"), dismissButton: .default(Text("Zurück")))
        }
        
    }
    
    func deleteDeck() {
        for (card) in cardList {
            if(card.cardToDeck == itemToDelete) {
                viewContext.delete(card)
             }
         }
        viewContext.delete(itemToDelete!)
        do {
            try viewContext.save()
            DeckSettings.value = nil
            print("Saving success")
        } catch {
            print("Unexpected error: \(error.localizedDescription).")
        }
    }
    
    
}

    
