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
            .clipped()
    }
    
}

extension String {
    var normalizedKey: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }
}


struct AvatarPlaceholderView: View{
    
    let size: CGFloat
    
    var body: some View{
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size,height: size)
            .foregroundStyle(.secondary)
            .clipShape(Circle())
    }
}
