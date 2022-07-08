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
    
    // Deck Variables
    @State private var deckTitle = DeckSettings.value?.title
    //@State private var deckColor = Color.blue // TODO: Change Defaultcolor
    @State private var cardsOfDeck:[Card] = []
    @State private var fetchedCards: NSSet?
    @State private var title = ""

    
    var body: some View {
        VStack {
            HStack {
                // Input for deck title
                TextField("Deck Titel", text: Binding(get: {return deckTitle ?? ""}, set: {changeTitle(str: $0)})).frame(height: 47)
                    .padding([.leading, .trailing], 15)
                    .background(Color.white, in: Capsule())
                
                ColorPicker("", selection: $bgColor).labelsHidden().scaleEffect(CGSize(width: 1.6, height: 1.6)).padding([.leading, .trailing], 15)
            }.padding(.bottom, 20)
            ScrollView {
            
                ForEach(
                    cardsOfDeck.indices,
                    id: \.self
                ) {
                    card in
                    ZStack(alignment: .trailing) {
                        
                        // Delete button
                        Button(action: {
                            DeckSettings.value?.removeFromDeckToCard(cardsOfDeck[card])
                            cardsOfDeck.remove(at: card)
                            cardPosition = 0
                        }) {
                            Image(systemName: "trash").font(.system(size: 26)).foregroundColor(Color.white).frame(width: smallButtonSize, height: smallButtonSize).background(Color.error).cornerRadius(smallButtonSize/2)
                        }.padding(.trailing, 10)
                        // Card
                    
                            VStack {
                                TextField("Begriff", text: Binding(get: {return cardsOfDeck[card].front ?? ""}, set: {saveCardFront(card: cardsOfDeck[card], val: $0)}))
                                    .frame(height: 40)
                                    .padding([.leading, .trailing], 15)
                                    .background(Color.white, in: Capsule())
                                TextField("Definition", text: Binding(get: {return cardsOfDeck[card].back ?? ""}, set: {saveCardBack(card: cardsOfDeck[card], val: $0)}))
                                    .frame(height: 40)
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
                }.padding(.bottom, 10)
            }.onAppear {
                DeckSettings.onDeckSave = {
                    if(DeckSettings.value == nil) {
                        DeckSettings.value = initDeck()
                    }
                    // Initialize Data
                    DeckSettings.value?.title = deckTitle
                    
                    
                    for card in cardsOfDeck {
                        
                        card.cardToDeck = DeckSettings.value
                        DeckSettings.value?.addToDeckToCard(card)
                    }
                    print("Trying to save the deck", DeckSettings.value!)
                        // Try saving
                        do {
                            try viewContext.save()
                            print("Saving success")
                        } catch {
                            print("Unexpected error: \(error.localizedDescription).")
                        }
                    DeckSettings.value = nil
                }
                if ( DeckSettings.value == nil ) {
                    cardsOfDeck.append(initCard())
                } else {
                    fetchedCards = (DeckSettings.value?.deckToCard)!
                    cardsOfDeck = fetchedCards?.allObjects as? [Card] ?? []
                    if(cardsOfDeck.isEmpty)  {
                        cardsOfDeck.append(initCard())
                    }
                }

            }
            Button(action: {
                cardsOfDeck.append(initCard())
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
    

    private func initDeck() -> Deck {
        let deck = Deck(context: viewContext)
        deck.id = UUID()
        
        return deck
    }
    
    
    
    private func initCard() -> Card {
        let card = Card(context: viewContext)
        
        // Initialize Data
        card.id = UUID()
        card.createdAt = Date()
        card.box = 0
        card.passedCount = 0
        card.failedCount = 0
        card.lastReviewed = card.createdAt
        
        card.cardToDeck = DeckSettings.value
        
        return card
    }
    
    
    
    private func saveCardFront(card: Card, val: String) {
        card.front = val
    }
    
    private func saveCardBack(card: Card, val: String) {
        card.back = val
    }
    
    private func changeTitle(str: String) {
        deckTitle = str
    }
    
    
}
