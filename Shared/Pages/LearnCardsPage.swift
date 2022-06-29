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
    @State var selection = Set<String>()
    @State var isSelected: Bool = true
    
    let names = [
           "Spanisch",
           "Deutsch",
           "OOP",
           "SWTP"
       ]
    var body: some View {
        VStack {
            
            // Input
            SearchInput()
            
            HStack {
                Text("\(selection.count)").font(Font.body.bold()).foregroundColor(Color.error)
                Text("Ausgewählt")
            }.frame(maxWidth: .infinity, alignment: .trailing).padding([.leading, .trailing], 30).padding(.top, 10)
            
            
            List(names, id: \.self, selection: $selection) {
                name in
                SelectDecksItem(name: name, selectedItems: $selection)
            }
            .background(Color.background.ignoresSafeArea())
            .onAppear {
                // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
            }
            
            Button(action: { print(selection)}) {
                Text("Learn selected").foregroundColor(Color.primary)
            }.padding(.top, 10)

            Spacer()
            
        }
        .background(Color.background)
    }
}
