//
//  AppTheme.swift
//  TeamHub
//
//  Created by Jarvis on 21/02/26.
//

import Foundation

enum AppTheme : String, CaseIterable, Identifiable{
    case light
    case dark
    case system
    var id: String {
        self.rawValue
    }
}
