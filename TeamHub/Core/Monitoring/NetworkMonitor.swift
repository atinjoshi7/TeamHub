//
//  NetworkMonitor.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Network
import Combine

protocol NetworkMonitoring {
    var isConnected: Bool { get }
    func start()
    func stop()
}

final class NetworkMonitor: NetworkMonitoring, ObservableObject {
    
    @Published private(set) var isConnected: Bool = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stop() {
        monitor.cancel()
    }
}
