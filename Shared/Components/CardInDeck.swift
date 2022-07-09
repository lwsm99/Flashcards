//
//  FullCardView.swift
//  Flashcards (iOS)
//
//  Created by II on 02.07.22.
//

import SwiftUI
import Foundation

struct CardInDeck: View {
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    // Parameter Variables
    let deckTitle: String
    let title: String
    let definition: String
    
    @State var showFront: Bool = true
    
    var body: some View {
        VStack {
            Color.background
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Text("\(deckTitle)")
                            .bold()
                            .font(.title)
                            .padding()
                        Spacer()
                        Text(showFront ? "\(title)" : "\(definition)")
                            .frame(width: 300, height: 350)
                            .padding()
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                            .padding()
                        Button(action: {
                            showFront = !showFront
                        }) {
                            Text(showFront ? "Rückseite zeigen" : "Vorderseite zeigen")
                                .frame(width: 320, height: 60)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                .padding()
                        }
                        Spacer()
                    }
                )
        }
    }
}
