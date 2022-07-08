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
                ProgressView("", value: progress, total: 1).accentColor(color)
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
                ForEach(cardList.indices, id: \.self) { idx in
                    if(cardList[idx].cardToDeck == deck) {
                        NavigationLink(destination: FullCardViewStatic(cardArray: getCardArray(), currCard: idx, deckSet: nil, showButtons: false)) {
                            DefaultCard(cardTitle: cardList[idx].front ?? "", cardDefinition: cardList[idx].back ?? "")
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
                DotsMenuButton(itemToDelete: deck)
            }
        }
    }
    private func getCardArray() -> [[Card]] {
        var cardArray: [[Card]] = [[]]
        for card in cardList {
            cardArray[0].append(card)
        }
        return cardArray
    }
}
                        
                           

