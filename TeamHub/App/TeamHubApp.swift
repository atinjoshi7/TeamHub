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
       
       init() {
           container.startNetworkMonitoring()
       }
       
       var body: some Scene {
           WindowGroup {
               HomeView(vm: container.makeHomeViewModel())
           }
       }
}
