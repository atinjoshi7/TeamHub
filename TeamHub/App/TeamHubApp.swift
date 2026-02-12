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

    private let container = AppDIContainer()
    @StateObject private var networkMonitor = NetworkMonitor()
       
//       init() {
//           container.startNetworkMonitoring()
//       }
       
       var body: some Scene {
           WindowGroup {
               HomeView(vm: container.makeHomeViewModel())
                   .environmentObject(networkMonitor)
                   .onAppear {
                       networkMonitor.start()
                   }
           }
       }
}
