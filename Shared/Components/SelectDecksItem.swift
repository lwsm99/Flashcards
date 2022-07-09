//
//  SelectDecksItem.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 28.06.22.
//

import Foundation
import SwiftUI

struct SelectDecksItem: View {
    var deck: Deck
    @Binding var selectedItems: Set<Deck>
    var isSelected: Bool {
        selectedItems.contains(deck)
    }
    
    var body: some View {
        HStack {
            Text(deck.title ?? "")
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill").foregroundColor(Color.primary)
            } else {
                Image(systemName: "checkmark.circle").foregroundColor(Color.primary)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isSelected {
                self.selectedItems.remove(deck)
            } else {
                self.selectedItems.insert(deck)
            }
        }
    }
}
