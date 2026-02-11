//
//  EmployeeAvatarView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI
import Kingfisher

import SwiftUI
import Kingfisher

struct EmployeeAvatarView: View {

    let imgURL: String?
    let size: CGFloat

    var body: some View {

        let url = EmployeeAvatarUrl.make(from: imgURL)

        Group {
            if let url = url {
                KFImage(url)
                    .placeholder { placeholder }
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
        .background(Color(.systemGray6))
        .clipShape(Circle())
    }

    private var placeholder: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFill()
            .padding(size * 0.22)
            .foregroundStyle(.secondary)
    }
}
