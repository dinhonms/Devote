//
//  DevoteApp.swift
//  Devote
//
//  Created by Nonato Sousa on 27/11/23.
//

import SwiftUI

@main
struct DevoteApp: App {
    @AppStorage("isLightMode") private var isLightMode = true
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isLightMode ? .light : .dark)
        }
    }
}
