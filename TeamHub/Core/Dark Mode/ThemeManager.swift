//
//  ThemeManager.swift
//  TeamHub
//
//  Created by Jarvis on 21/02/26.
//

import SwiftUI
import Combine

final class ThemeManager: ObservableObject{
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

//    @Published var isDarkMode: Bool {
//           didSet {
//               isDarkStored = isDarkMode
//           }
//       }
//    
//    init() {
//        isDarkMode = isDarkStored
//    }
         
    var colorScheme: ColorScheme {
           isDarkMode ? .dark : .light
       }
}
