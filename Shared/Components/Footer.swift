//
//  Footer.swift
//  Flashcards (iOS)
//
//  Created by Luiza Shishina on 20.06.22.
//

import Foundation
import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 100, height: 100)
            .foregroundColor(Color.black)
            .background(Color.red)
            .clipShape(Circle())
    }
}

struct Footer: View {
    @State var selectedIndex = 0
    let icons = [
        "house",
        "plus",
        "book"
    ]
    let middleButtonSize: CGFloat = 60
    var body: some View {
        VStack {
            ZStack {
                NavigationView {
                    switch selectedIndex {
                    case 1:
                        AddCardsPage()
                            .toolbar {
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                    Text("App Name").bold().foregroundColor(Color.primary).textCase(.uppercase)
                                }
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                    DotsMenuButton()
                                }
                           }
                    case 2:
                        LearnCardsPage()
                            .toolbar {
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                    Text("App Name").bold().foregroundColor(Color.primary).textCase(.uppercase)
                                }
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                    DotsMenuButton()
                                }
                           }
                    default:
                    
                        StartPage()
                            .toolbar {
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                    Text("App Name").bold().foregroundColor(Color.primary).textCase(.uppercase)
                                }
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                    DotsMenuButton()
                                }
                           }
                    }
                }
                
            }
            
            Spacer().frame(height:30)
            
            HStack {
                ForEach(0..<3,id: \.self) { number in
                    Spacer()
                    Button(action: { self.selectedIndex = number }, label: {
                        if number == 1 {
                            Image(systemName: icons[number]).font(.system(size: 26)).foregroundColor(Color.white).frame(width: middleButtonSize, height: middleButtonSize).background(Color.primary).cornerRadius(middleButtonSize/2)
                        } else {
                            Image(systemName: icons[number]).foregroundColor( selectedIndex == number ? Color.primary : Color.disabled).font(.system(size: 26))
                        }
                        
                        
                    })
                    Spacer()
                }
            }
        }.background(Color.background)
    }
}
