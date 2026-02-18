//
//  ActiveFilterPill.swift
//  TeamHub
//
//  Created by Jarvis on 13/02/26.
//

import SwiftUI

struct FiltersActivePill: View {

    let onClear: () -> Void

    var body: some View {
        HStack(spacing: 10) {

            Label("Filters Active", systemImage: "line.3.horizontal.decrease.circle.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)

            Spacer()

            Button {
                onClear()
            } label: {
                Text("Clear")
                    .font(.subheadline.weight(.semibold))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.thinMaterial)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(.quaternary, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
