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
    @Environment(\.managedObjectContext) private var viewContext
    
    let icons = [
        "house",
        "plus",
        "book"
    ]
    func middleButtonAction(index: Int) {
        if(self.selectedIndex == 1 && index == 1) {
            DeckSettings.onDeckSave!()
            self.selectedIndex = 0
        } else if (self.selectedIndex == 0 && index == 1) {
            self.selectedIndex = index;
        }
        else {
            DeckSettings.value = nil
            self.selectedIndex = index;
        }
        
    }
    
    let middleButtonSize: CGFloat = 60
    var body: some View {
        VStack {
            ZStack {
                NavigationView {
                    switch selectedIndex {
                    case 1:
                        AddCardsPage().toolbar {
                            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                Text("App Name").bold().foregroundColor(Color.primary).textCase(.uppercase)
                            }
                            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                DotsMenuButton(itemToDelete: nil)
                            }
                        }
                    case 2:
                        LearnCardsPage()
                            .toolbar {
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                    Text("App Name").bold().foregroundColor(Color.primary).textCase(.uppercase)
                                }
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                    DotsMenuButton(itemToDelete: nil)
                                }
                           }
                    default:
                        StartPage()
                            .toolbar {
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                    Text("App Name").bold().foregroundColor(Color.primary).textCase(.uppercase)
                                }
                                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                    DotsMenuButton(itemToDelete: nil)
                                }
                           }
                    }
                }
                
            }
            
            Spacer().frame(height:30)
            
            HStack {
                ForEach(0..<3,id: \.self) { number in
                    Spacer()
                    Button(action: { middleButtonAction(index: number) }, label: {
                        if number == 1 {
                            Image(systemName: self.selectedIndex == 1 ? "checkmark" : icons[number]).font(.system(size: 26)).foregroundColor(Color.white).frame(width: middleButtonSize, height: middleButtonSize).background(Color.primary).cornerRadius(middleButtonSize/2)
                        } else {
                            Image(systemName: icons[number]).foregroundColor( selectedIndex == number ? Color.disabled : Color.primary).font(.system(size: 26))
                        }
                    })
                    Spacer()
                }
            }
        }.background(Color.background).ignoresSafeArea(.keyboard)
    }
}
