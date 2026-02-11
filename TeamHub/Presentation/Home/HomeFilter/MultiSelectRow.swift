//
//  MultiSelectRow.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import SwiftUI

struct MultipleSelectRow: View {

    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}
