//
//  NoInternetView.swift
//  TeamHub
//
//  Created by Jarvis on 12/02/26.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack(spacing: 16){
            Image(systemName: "wifi.slash")
                .font(.system(size: 52, weight: .semibold))
                .foregroundStyle(.secondary)
            Text("No Internet Connection")
                .font(.title2.bold())
            Text("Please check your network and try again.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}
