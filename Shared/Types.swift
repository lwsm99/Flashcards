//
//  Types.swift
//  Flashcards
//
//  Created by Luiza Shishina on 07.07.22.
//

import Combine
import Foundation

class DeckSettings {
    static var value: Deck? = nil;
    static var onDeckSave: (() -> Void)? = nil;
}
