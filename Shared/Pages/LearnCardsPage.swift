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
    @State var selection = Set<Deck>()
    @State var isSelected: Bool = true
    @State var freeLearn: Bool = false
    
    var body: some View {
        VStack {
            
            // Input
            SearchInput()
            
            HStack {
                Text("\(selection.count)").font(Font.body.bold()).foregroundColor(Color.error)
                Text("Ausgewählt")
            }.frame(maxWidth: .infinity, alignment: .trailing).padding([.leading, .trailing], 30).padding(.top, 10)
            Toggle("Free-Learn Modus", isOn: $freeLearn)
               .padding([.top, .leading, .trailing])
            List(deckList, id: \.self, selection: $selection) {
                deck in
                SelectDecksItem(deck: deck, selectedItems: $selection)
            }
            .background(Color.background.ignoresSafeArea())
            .onAppear {
                // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
            }
            
            if(selection.count > 0) {
                NavigationLink(destination: FullCardViewStatic(cardArray: freeLearn ? getCardArrayFree() : getCardArraySRS(), currCard: 0, deckSet: selection, showButtons: true)) {
                    Text("Ausgewählte Decks lernen").foregroundColor(Color.primary)
                }.padding(.top, 10)
            } else {
                Text("Wähle Decks aus um zu lernen").foregroundColor(Color.secondary)
            }

            Spacer()
            
        }
        .background(Color.background)
    }
    
    private func getCardArrayFree() -> [[Card]] {
        var cardArray: [[Card]] = [[]]
        
        for (idx, deck) in selection.enumerated() {
            if(idx != 0) { cardArray.append([]) }
            for card in cardList {
                if(card.cardToDeck == deck) {
                    cardArray[idx].append(card)
                }
            }
        }
        return cardArray
    }
    
    private func getCardArraySRS() -> [[Card]] {
        var cardArray: [[Card]] = [[]]
        
        for (idx, deck) in selection.enumerated() {
            if(idx != 0) { cardArray.append([]) }
            for card in cardList {
                if(card.cardToDeck == deck) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let firstDate = card.nextReview
                    let secondDate = Date.now
                    if (!(firstDate!.compare(secondDate) == .orderedDescending)) {
                        cardArray[idx].append(card)
                    }
                }
            }
        }
        print(Date.now)
        return cardArray
    }
}
