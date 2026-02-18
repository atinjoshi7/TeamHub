//
//  EmployeeRowView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI
import Kingfisher

struct EmployeeRowView: View {
    
    let employee: Employee
    
    var body: some View {
        let url = EmployeeAvatarUrl.make(from: employee.imgURL ?? "")
        Group{
            HStack(spacing: 12) {
                
                if let url = url{
                    KFImage(url)
                        .placeholder {
                           // shows a apple generated image. e.g, person.
                           AvatarPlaceholderView(size: 62)
                        }
                        // shows downloaded image.
                        .resizable()
                        .imgProp(size: 62)
                        .clipShape(Circle())
                }else {
                    // This block gets executed when url is nil.
                    AvatarPlaceholderView(size: 62)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    // Employee name
                    Text(employee.name)
                        .font(.headline)
                    
                    // Employee department and designation
                    Text("\(employee.designation) • \(employee.department)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Employee status
                Text(employee.isActive ? "Active" : "Inactive")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal,10)
                    .padding(.vertical,4)
                    .background(
                        Capsule()
                            .fill(employee.isActive
                                  ?
                                Color.green
                                .opacity(0.15)
                                  : Color.red.opacity(0.15))
                    ).foregroundStyle(employee.isActive ? .green: .red)
//                    .padding(.top, -10)
            }
            .padding(.vertical, 6)
        }
    }
}

