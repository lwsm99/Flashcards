//
//  SelectDecksItem.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 28.06.22.
//

import Foundation
import SwiftUI

struct SelectDecksItem: View {
    var name: String
    @Binding var selectedItems: Set<String>
    var isSelected: Bool {
        selectedItems.contains(name)
    }
    
    var body: some View {
        HStack {
            Text(name)
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
                self.selectedItems.remove(name)
            } else {
                self.selectedItems.insert(name)
            }
        }
    }
}
