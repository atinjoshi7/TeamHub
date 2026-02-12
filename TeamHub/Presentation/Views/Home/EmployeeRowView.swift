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
                Circle()
                    .fill(employee.isActive ? Color.green : Color.red)
                    .frame(width: 10, height: 10)
            }
            .padding(.vertical, 6)
        }
    }
}

