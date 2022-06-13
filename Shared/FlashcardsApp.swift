//
//  FlashcardsApp.swift
//  Shared
//
//  Created by Lucas Weissmann on 13.06.22.
//

import SwiftUI

@main
struct FlashcardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
