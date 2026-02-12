//
//  HomeConnectivityViewModel.swift
//  TeamHub
//
//  Created by Jarvis on 12/02/26.
//

import Foundation
import Combine

@MainActor
final class HomeConnectivityViewModel: ObservableObject {

    @Published var showOfflineBanner: Bool = false
    @Published var showOnlineBanner: Bool = false

    private var lastConnectionState: Bool?

    func handleConnectionChange(isConnected: Bool) async {

        // first time
        if lastConnectionState == nil {
            lastConnectionState = isConnected
            showOfflineBanner = (isConnected == false)
            return
        }

        // OFF -> ON
        if lastConnectionState == false && isConnected == true {
            showOfflineBanner = false
            showOnlineBanner = true

            try? await Task.sleep(nanoseconds: 2_000_000_000)

            showOnlineBanner = false
        }

        // ON -> OFF
        if lastConnectionState == true && isConnected == false {
            showOfflineBanner = true
        }

        lastConnectionState = isConnected
    }
}

