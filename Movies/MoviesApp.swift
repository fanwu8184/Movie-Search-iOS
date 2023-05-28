//
//  MoviesApp.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

@main
struct MoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
