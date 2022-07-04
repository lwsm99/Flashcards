//
//  DeckCardMenu.swift
//  Flashcards (iOS)
//
//  Created by II on 24.06.22.
//

import SwiftUI

struct DeckCardMenu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.id, ascending: true)], animation: .default) private var cardList: FetchedResults<Card>
    
    let title: String
    let cardCount: Int
    let progress: CGFloat
    @Binding var color: Color
    let deck: Deck
    
    //TODO: Fetch only for current deck
    
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
                    NavigationLink(destination: FullCardView()) {
                        DefaultCard(cardTitle: card.front!, cardDefinition: card.back!)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .foregroundColor(.black)
                    Spacer().frame(height: 20)
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
                Text("\(cardCount)")
                    .foregroundColor(.gray)
            }
        }
    }
}
