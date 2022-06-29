//
//  SearchInput.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 28.06.22.
//

import Foundation
import SwiftUI

struct SearchInput: View {
    @State private var inputValue: String = ""
    
    var body: some View {
        HStack {
            Spacer().frame(width:15)
            HStack {
                TextField("Name des Decks eingeben", text: $inputValue)
                Image(systemName: "magnifyingglass").foregroundColor(Color.disabled)
            }.frame(height: 47)
                .padding([.leading, .trailing], 15)
                .background(Color.white, in: Capsule())
            Spacer().frame(width:15)
        }
    }
}
