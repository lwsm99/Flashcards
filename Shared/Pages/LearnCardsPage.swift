//
//  LearnCardsPage.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 21.06.22.
//

import Foundation
import SwiftUI

struct ToggleCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: "checkmark.square").symbolVariant(configuration.isOn ? .fill : .none)
    }
}

struct LearnCardsPage: View {
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Deck.title, ascending: true)], animation: .default) private var deckList: FetchedResults<Deck>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], animation: .default) private var cardList: FetchedResults<Card>
    
    // Variables
    @State var selection = Set<String>()
    @State var isSelected: Bool = true

    
    /**
     Fetch all decks
     Decks selected -> Fetch all cards for selected decks
     Render card
     */
    
    var body: some View {
        VStack {
            
            // Input
            SearchInput()
            
            HStack {
                Text("\(selection.count)").font(Font.body.bold()).foregroundColor(Color.error)
                Text("Ausgewählt")
            }.frame(maxWidth: .infinity, alignment: .trailing).padding([.leading, .trailing], 30).padding(.top, 10)
            
            
            List(deckList, id: \.self, selection: $selection) {
                deck in
                SelectDecksItem(name: deck.title ?? "", selectedItems: $selection)
            }
            .background(Color.background.ignoresSafeArea())
            .onAppear {
                // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
            }
            
            
            NavigationLink(destination: FullCardViewStatic(cardList: cardList, currCard: 0, showButtons: true)) {
                Text("Learn selected").foregroundColor(Color.primary)
            }.padding(.top, 10)

            Spacer()
            
        }
        .background(Color.background)
    }
}
