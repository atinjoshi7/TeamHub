//
//  Constants.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import SwiftUI

extension View{
    
    func imgProp(size: CGFloat) -> some View{
        self
            .scaledToFill()
            .frame(width: size, height: size)
    }
    
}

extension String {
    var normalizedKey: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }
}
