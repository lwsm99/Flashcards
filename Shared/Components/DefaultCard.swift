//
//  DefaultCard.swift
//  Flashcards (iOS)
//
//  Created by II on 27.06.22.
//

import SwiftUI

struct DefaultCard: View {
    let cardTitle: String
    let cardDefinition: String
    let number: Int
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            Text("\(cardTitle) \(number)")
                .font(.subheadline)
                .bold()
                .padding()
                .frame(width: 350, height: 20, alignment: .leading)
            Text("\(cardDefinition)")
                .font(.caption)
                .padding()
                .frame(width: 350, height: 10, alignment: .leading)
            Spacer().frame(height: 20)
        }
    }
}
