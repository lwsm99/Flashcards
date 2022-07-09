//
//  DeckCardMenu.swift
//  Flashcards (iOS)
//
//  Created by II on 24.06.22.
//

import SwiftUI

struct DeckCardMenu: View {
    
    // Variables
    let title: String
    let cardCount: Int
    let progress: CGFloat
    @State private var isStatOpen: Bool = false
    @Binding var color: Color
    let deck: Deck
    
    // Fetch Requests
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.createdAt, ascending: true)], animation: .default) var cardList: FetchedResults<Card>
    
    var body: some View {
        
        VStack {
            // MARK: Title
            /*
            HStack {
                Text("\(title)")
                    .font(.title)
                    .bold()
                RoundedRectangle(cornerRadius: 5).fill(color).frame(width: 25, height: 25)
                Text("(\(cardCount))")
                    .foregroundColor(.gray)
                Spacer().frame(width: 130)
                DotsMenuButton()
            }
             */
            // MARK: Progress
            HStack {
                ProgressView("", value: progress, total: 1).accentColor(color)
            }.padding([.leading, .trailing], 10)
            Spacer().frame(height: 20)
            
            // MARK: Statistics
            VStack {
                HStack {
                    Text("Statistiken")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .padding()
                        .frame(width: 315, height: 40, alignment: .leading)
                    Button(action: {
                        print("Open stats")
                        isStatOpen = !isStatOpen
                    }) {
                        Image(systemName: isStatOpen ? "chevron.up" : "chevron.down").foregroundColor(.white)
                    }
                    Spacer().frame(width: 10)
                }
                if(isStatOpen) {
                    VStack {
                        Text("Neue Flashcards: \(getNewCardCount())")
                            .font(.headline)
                            .frame(width: 315, alignment: .leading)
                            .padding(.bottom, 10)

                        Text("Heute anstehend: \(getTodayCardCount())")
                            .font(.headline)
                            .frame(width: 315, alignment: .leading)
                            .padding(.bottom, 10)
                        VStack {
                            Text("Boxen:")
                                .font(.headline)
                                .frame(width: 315, alignment: .leading)
                                .padding(.bottom, 10)
                            
                            ForEach(0...4, id: \.self) {
                                number in
                                if(getBoxCardCount(deck: deck, box: number) == 0) {
                                } else {
                                    VStack(alignment: .leading) {
                                        if(number == 0) {
                                            Text("Neu/Failed")
                                                .padding(.bottom, -10)
                                        } else {
                                            Text("Box \(number)")
                                                .padding(.bottom, -10)
                                        }
                                        HStack {
                                            ProgressView("", value: getBoxCardCount(deck: deck, box: number), total: getMaxBoxCardCount(deck: deck))
                                                .accentColor(number == 0 ? .red : .green)
                                                .scaleEffect(x: 1, y: 2)
                                                .padding(.top, -27)
                                            Spacer()
                                            Text("\(Int(getBoxCardCount(deck: deck, box: number)))")
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.background))
                        .foregroundColor(.black)
                        /*
                        VStack(alignment: .leading) {
                            Text("Neu/Failed")
                                .padding(.bottom, -10)
                            HStack {
                                ProgressView("", value: getBoxCardCount(deck: deck, box: 0), total: getMaxBoxCardCount(deck: deck))
                                    .accentColor(.red)
                                    .scaleEffect(x: 1, y: 2)
                                    .padding(.top, -27)
                                Spacer()
                                Text("\(Int(getBoxCardCount(deck: deck, box: 0)))")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Box 1")
                                .padding(.bottom, -10)
                            HStack {
                                ProgressView("", value: getBoxCardCount(deck: deck, box: 1), total: getMaxBoxCardCount(deck: deck))
                                    .accentColor(.green)
                                    .scaleEffect(x: 1, y: 2)
                                    .padding(.top, -27)
                                Spacer()
                                Text("\(Int(getBoxCardCount(deck: deck, box: 1)))")
                            }
                        }.frame(alignment: .leading)
                        VStack(alignment: .leading) {
                            Text("Box 2")
                                .padding(.bottom, -10)
                            HStack {
                                ProgressView("", value: getBoxCardCount(deck: deck, box: 2), total: getMaxBoxCardCount(deck: deck))
                                    .accentColor(.green)
                                    .scaleEffect(x: 1, y: 2)
                                    .padding(.top, -27)
                                Spacer()
                                Text("\(Int(getBoxCardCount(deck: deck, box: 2)))")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Box 3")
                                .padding(.bottom, -10)
                            HStack {
                                ProgressView("", value: getBoxCardCount(deck: deck, box: 3), total: getMaxBoxCardCount(deck: deck))
                                    .accentColor(.green)
                                    .scaleEffect(x: 1, y: 2)
                                    .padding(.top, -27)
                                Spacer()
                                Text("\(Int(getBoxCardCount(deck: deck, box: 3)))")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Box 4")
                                .padding(.bottom, -10)
                            HStack {
                                ProgressView("", value: getBoxCardCount(deck: deck, box: 4), total: getMaxBoxCardCount(deck: deck))
                                    .accentColor(.green)
                                    .scaleEffect(x: 1, y: 2)
                                    .padding(.top, -27)
                                Spacer()
                                Text("\(Int(getBoxCardCount(deck: deck, box: 4)))")
                            }
                        } */
                    }
                    .frame(width: 315).background(RoundedRectangle(cornerRadius: 10).fill(.blue))
                    .foregroundColor(.white)
                    .padding()
                }
            }
            .background(RoundedRectangle(cornerRadius: 13).fill(.blue))

            Spacer().frame(height: 30)
            
            // MARK: Cards
            ScrollView {
                ForEach(cardList.indices, id: \.self) { idx in
                    if(cardList[idx].cardToDeck == deck) {
                        NavigationLink(destination: CardInDeck(deckTitle: title, title: cardList[idx].front ?? "Missing title!", definition: cardList[idx].back ?? "Missing definition!")) {
                            DefaultCard(cardTitle: cardList[idx].front ?? "", cardDefinition: cardList[idx].back ?? "")
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        .foregroundColor(.black)
                        Spacer().frame(height: 20)
                    }
                }
                /*
                ForEach(1...cardCount, id: \.self) {
                    number in
                    NavigationLink(destination: FullCardViewStatic(front: "Begriff", back:"Definition", title: title, showButtons: false)) {
                        DefaultCard(cardTitle: "Begriff", cardDefinition: "Definition", number: number)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .foregroundColor(.black)
                    Spacer().frame(height: 20)
                 */
                
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)
        .navigationTitle("\(title)")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                DotsMenuButton(itemToDelete: deck)
            }
        }
    }
    private func getCardArray() -> [[Card]] {
        var cardArray: [[Card]] = [[]]
        for card in cardList {
            cardArray[0].append(card)
        }
        return cardArray
    }
    
    private func getNewCardCount() -> Int {
        var counter = 0
        for (idx) in cardList.indices {
            if(cardList[idx].cardToDeck == deck) {
                if(cardList[idx].lastReviewed == nil) {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    private func getTodayCardCount() -> Int {
        //TODO: Cap count at specific value?
        var counter = 0
        for (idx) in cardList.indices {
            if(cardList[idx].cardToDeck == deck) {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let firstDate = cardList[idx].nextReview
                let secondDate = Date.now
                if (!(firstDate!.compare(secondDate) == .orderedDescending)) {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    private func getBoxCardCount(deck: Deck, box: Int) -> Double {
        var counter = 0
        for card in cardList {
            if(card.cardToDeck == deck && box >= 4 && Int(floor(card.box)) >= box) {
                counter += 1
            }
            else if(card.cardToDeck == deck && Int(floor(card.box)) == box) {
                counter += 1
            }
        }
        return Double(counter)
    }
    
    private func getMaxBoxCardCount(deck: Deck) -> Double {
        var counter = getBoxCardCount(deck: deck, box: 0)
        for box in 1...4 {
            if(getBoxCardCount(deck: deck, box: box) > counter) {
                counter = getBoxCardCount(deck: deck, box: box)
            }
        }
        return Double(counter)
    }
}
                        
                           

