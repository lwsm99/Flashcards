//
//  DeckCard.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 21.06.22.
//

import Foundation
import SwiftUI

struct DeckCard: View {
    @Binding var color: Color
    let title: String
    let subtitle: String
    let progress: CGFloat
    
    var body: some View {
        Button(action: {}){
            VStack {
                HStack{
                    RoundedRectangle(cornerRadius: 10).fill(color).frame(width: 60, height: 60)
                    VStack {
                        Text(title).font(.headline).foregroundColor(Color.primary)
                        Text(subtitle).font(.headline).foregroundColor(Color.disabled).fontWeight(.light)
                    }.padding([.leading, .trailing], 10)
                    Spacer()
                }.frame(maxWidth: .infinity)
                ProgressView("", value: progress, total: 100).accentColor(color)
            }.frame(maxWidth: .infinity).padding(16).background(Color.white).cornerRadius(20).padding([.leading, .trailing], 15)
        }
    }
}
