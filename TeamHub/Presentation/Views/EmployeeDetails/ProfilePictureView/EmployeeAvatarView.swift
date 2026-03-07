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

    @Binding var canOpenPfp: Bool
    @State private var loadFailed = false
    
    /*This is the image of user in the details screen, it is created separartely for image related code handling and making it reusable in future use.*/
    var body: some View {

        let url = EmployeeAvatarUrl.make(from: imgURL)

        Group {
            if let url = url, loadFailed == false {
                KFImage(url)
                    .onSuccess { _ in
                        canOpenPfp = true
                    }
                    .onFailure{ _ in
                        loadFailed = true
                        canOpenPfp = false
                    }
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

    /* System generated person image with some functionalities */
    private var placeholder: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFill()
            .padding(size * 0.22)
            .foregroundStyle(.secondary)
    }
}
