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
        HStack(spacing: 12) {
            let urlString = employee.imgURL?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let urlString = urlString, urlString.isEmpty == false,
               let url = URL(string: urlString){
                KFImage(url)
                    .placeholder {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 62,height: 62)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                    .resizable()
                    .imgProp(size: 62)
                    .clipShape(Circle())
            }else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 62,height: 62)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(employee.name)
                    .font(.headline)
                
                Text("\(employee.designation) • \(employee.department)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Circle()
                .fill(employee.isActive ? Color.green : Color.red)
                .frame(width: 10, height: 10)
        }
        .padding(.vertical, 6)
    }
}

