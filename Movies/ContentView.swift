//
//  ContentView.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        SearchScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.mainContext)
    }
}
