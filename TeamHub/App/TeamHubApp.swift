//
//  TeamHubApp.swift
//  TeamHub
//
//  Created by Jarvis on 10/02/26.
//

import SwiftUI
import CoreData

@main
struct TeamHubApp: App {
    
    
    let container = AppDIContainer()
    @StateObject private var networkMonitor = NetworkMonitor()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView(vm: container.makeHomeViewModel())
                .environmentObject(networkMonitor)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
                .onAppear {
                    networkMonitor.start()
                }
        }
    }
}
