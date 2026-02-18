//
//  NoUserFound.swift
//  TeamHub
//
//  Created by Jarvis on 18/02/26.
//

import SwiftUI


import SwiftUI

struct NoUserFound: View {

    var body: some View {
        VStack(spacing: 16) {

            Image(systemName: "person.3.fill")
                .font(.system(size: 52, weight: .semibold))
                .foregroundStyle(.secondary)

            Text("No Employees Found")
                .font(.title2.bold())

            Text("Try changing your search or filters.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}


#Preview {
 
}
