//
//  DeckCardMenu.swift
//  Flashcards (iOS)
//
//  Created by II on 24.06.22.
//

import SwiftUI

struct DeckCardMenu: View {
    
    // Variables
    let title: String
    let cardCount: Int
    let progress: CGFloat
    @Binding var color: Color
    let deck: Deck
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    
    // TODO: Ich komme an deck nicht ran, weil es hier noch nicht initialisiert wurde
    //@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], predicate: NSPredicate(format: "cardToDeck == %@", deck), animation: .default) var cardList: FetchedResults<Card>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], animation: .default) var cardList: FetchedResults<Card>
    
    var body: some View {
        
        VStack {
            // MARK: Title
            /*
            HStack {
                Text("\(title)")
                    .font(.title)
                    .bold()
                RoundedRectangle(cornerRadius: 5).fill(color).frame(width: 25, height: 25)
                Text("(\(cardCount))")
                    .foregroundColor(.gray)
                Spacer().frame(width: 130)
                DotsMenuButton()
            }
             */
            // MARK: Progress
            HStack {
                ProgressView("", value: progress, total: 100).accentColor(color)
            }.padding([.leading, .trailing], 10)
            Spacer().frame(height: 20)
            
            // MARK: Statistics
            HStack {
                Text("Statistiken")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .bold()
                    .padding()
                    .frame(width: 315, height: 35, alignment: .leading)
                Image(systemName: "chevron.down").foregroundColor(.white)
                Spacer().frame(width: 10)
            }.background(RoundedRectangle(cornerRadius: 10).fill(.blue))
            Spacer().frame(height: 30)
            
            // MARK: Cards
            ScrollView {
                ForEach(cardList) { card in
                    if(card.cardToDeck == deck) {
                        NavigationLink(destination: FullCardViewStatic(front: card.front ?? "", back: card.back ?? "", title: title, showButtons: false)) {
                            DefaultCard(cardTitle: card.front ?? "", cardDefinition: card.back ?? "")
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        .foregroundColor(.black)
                        Spacer().frame(height: 20)
                    }
                }
                /*
                ForEach(1...cardCount, id: \.self) {
                    number in
                    NavigationLink(destination: FullCardViewStatic(front: "Begriff", back:"Definition", title: title, showButtons: false)) {
                        DefaultCard(cardTitle: "Begriff", cardDefinition: "Definition", number: number)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .foregroundColor(.black)
                    Spacer().frame(height: 20)
                 */
                
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)
        .navigationTitle("\(title)")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Menu {
                    Section {
                        Button(action: {deleteDeck()}) {
                            Label("Deck löschen", systemImage: "bubble.middle.bottom")
                        }
                        
                        Button(action: {}) {
                            Label("Impressum", systemImage: "doc")
                        }
                    }
                }
                label: {
                    Label("More", systemImage: "ellipsis").foregroundColor(Color.primary)
                }
            }
        }
    }
    
    func deleteDeck() {
        for (card) in cardList {
            if(card.cardToDeck == deck) {
                viewContext.delete(card)
             }
         }
        viewContext.delete(deck)
    }
}
                        
                           

