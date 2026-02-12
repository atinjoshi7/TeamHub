//
//  Shimmer.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI


struct ShimmerModifier: ViewModifier {

    @State private var moveToRight: Bool = false

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    .clear,
                                    .white.opacity(0.35),
                                    .clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .rotationEffect(.degrees(18))
                        .offset(x: moveToRight ? geo.size.width * 2 : -geo.size.width * 2)
                        .blendMode(.plusLighter)
                        .onAppear {
                            withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                                moveToRight = true
                            }
                        }
                }
            }
            .mask(content)
    }
}

extension View {
    func shimmer(_ active: Bool) -> some View {
        if active {
            return AnyView(self.modifier(ShimmerModifier()))
        } else {
            return AnyView(self)
        }
    }
}



