//
//  EmployeeShimmerView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI

struct EmployeeRowShimmerView: View {

    var body: some View {
        HStack(spacing: 12) {

            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 52, height: 52)

            VStack(alignment: .leading, spacing: 8) {

                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(.systemGray5))
                    .frame(width: 160, height: 14)

                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(.systemGray5))
                    .frame(width: 220, height: 12)
            }

            Spacer()

            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 10, height: 10)
        }
        .padding(.vertical, 6)
        .shimmer(true)
    }
}

