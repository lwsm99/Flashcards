//
//  DotsMenuButton.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 21.06.22.
//

import Foundation
import SwiftUI

struct DotsMenuButton: View {
    var body: some View {
        Menu {
            Section {
                Button(action: {}) {
                    Label("Feedback", systemImage: "bubble.middle.bottom")
                }
                
                Button(action: {}) {
                    Label("Kontakt", systemImage: "person")
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
