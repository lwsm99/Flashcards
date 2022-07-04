//
//  FullCardView.swift
//  Flashcards (iOS)
//
//  Created by II on 02.07.22.
//

import SwiftUI
import Foundation

struct FullCardViewStatic: View {
    let front: String
    let back: String
    let title: String
    let showButtons: Bool
    @State private var showFront: Bool = true
    var body: some View {
        VStack {
            Color.background
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Text("\(title)")
                            .bold()
                            .font(.title)
                        Spacer().frame(height: 60)
                        Button(action: {showFront = !showFront}) {
                            Text(showFront ? "\(front)" : "\(back)" )
                                .frame(width: 300, height: 350)
                                .padding()
                                .foregroundColor(.black)
                        }.background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        if(showButtons) {
                            Spacer().frame(height: 30)
                            HStack {
                                Button {
                                    
                                } label: {
                                    Text("🙂")
                                }.frame(width: 60, height: 60)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                Spacer().frame(width: 30)
                                Button {
                                    
                                } label: {
                                    Text("😐")
                                }.frame(width: 60, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                Spacer().frame(width: 30)
                                Button {
                                    
                                } label: {
                                    Text("☹️")
                                }.frame(width: 60, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                Spacer().frame(width: 30)
                                Button {
                                    
                                } label: {
                                    Text("♻️")
                                }.frame(width: 60, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                            }
                            Spacer().frame(height: 40)
                        }
                        if(!showButtons) {
                            Spacer().frame(height: 100)
                        }
                    }
                )
            
        }
    }
}
