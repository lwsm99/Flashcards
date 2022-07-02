//
//  DeckCardMenu.swift
//  Flashcards (iOS)
//
//  Created by II on 24.06.22.
//

import SwiftUI

struct DeckCardMenu: View {
    let title: String
    let cardCount: Int
    let progress: CGFloat
    @Binding var color: Color
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
                ForEach(1...cardCount, id: \.self) {
                    number in
                    //NavigationLink(destination: FullCardView()) {
                        DefaultCard(cardTitle: "Begriff", cardDefinition: "Definition", number: number)
                    //}
                }
            }
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
