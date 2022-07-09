//
//  Extensions.swift
//  Flashcards
//
//  Created by Luiza Shishina on 20.06.22.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let primary = Color("Primary")
    static let error = Color("Error")
    static let statisticsPrimary = Color("StatisticsPrimary")
    static let statisticsSecondary = Color("StatisticsSecondary")
    static let statisticsTertiary = Color("StatisticsTertiary")
    static let disabled = Color("Disabled")
    static let uncreatedCardColor = Color("UncreatedCard")
    static let systemBackground = Color(uiColor: .systemBackground)
}

// Source: https://stackoverflow.com/questions/68543882/cannot-convert-value-of-type-bindingstring-to-expected-argument-type-bindi
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
