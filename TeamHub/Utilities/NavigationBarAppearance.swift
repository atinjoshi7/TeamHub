//
//  NavigationBarAppearance.swift
//  TeamHub
//
//  Created by Jarvis on 13/02/26.
//

import Foundation
import UIKit

enum NavigationBarAppearance {
    
    static func applySolidStyle() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Uses system background (light/dark mode friendly)
        appearance.backgroundColor = UIColor.systemBackground
        
        // ✅ Important: Title colors
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        // Optional: remove bottom shadow line
        // appearance.shadowColor = nil
        
        let navBar = UINavigationBar.appearance()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        navBar.prefersLargeTitles = true
    }
}
