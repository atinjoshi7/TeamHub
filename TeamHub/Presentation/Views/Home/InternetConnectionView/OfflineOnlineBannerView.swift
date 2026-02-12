//
//  ConnectivityBanner.swift
//  TeamHub
//
//  Created by Jarvis on 12/02/26.
//

import SwiftUI

struct ConnectivityBanner: View {
    
    enum Style{
        case offline
        case online
    }
    
    let style: Style
    let text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(backgroundColor)
            .clipShape(Capsule())
            .shadow(radius: 8)
            .padding(.top, 8)
    }
    
    private var backgroundColor: Color{
        if style == .offline{
            return .red.opacity(0.9)
        }else{
            return .green.opacity(0.9)
        }
    }
}
