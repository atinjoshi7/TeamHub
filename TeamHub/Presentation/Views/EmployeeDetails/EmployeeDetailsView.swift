//
//  EmployeeDetailsView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI
import Kingfisher
struct EmployeeDetailsView: View {

    let employee: Employee

    @State private var isFullScreenImage = false
    @State private var goToPfp = false
    @State private var canOpenpfp = false
    
    var body: some View {
        
        ZStack {
            
            /*shows all the details of user like image, name, active status, department, designation, contact,
            joinging date, country and city. */
            List {
                Section {
                    HStack(spacing: 14) {
                        
                        
                        EmployeeAvatarView(
                            imgURL: employee.imgURL,
                            size: 80,
                            canOpenPfp: $canOpenpfp
                        ) .onTapGesture {
                            if canOpenpfp{
                                goToPfp = true
                            }
                            }
                        
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(employee.name)
                                .font(.title3.bold())
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                        Text(employee.isActive ? "Active" : "Inactive")
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal)
                            .padding(.vertical,1)
                            .background(
                                Capsule()
                                    .fill(
                                        employee.isActive ? Color.green.opacity(0.25) : Color.red.opacity(0.25)
                                    )
                            )
                            .foregroundStyle(employee.isActive ? Color.green : Color.red)
                    }
                    .padding(.vertical, 8)
                }
                Section("Designation"){
                    Text(employee.designation)
                }
                Section("Department"){
                    Text(employee.department)
                }
                Section("Contact") {
                    Text(employee.email)
                }

                Section("Location") {
                    Text("\(employee.city), \(employee.country)")
                        .foregroundStyle( employee.city == "N/A" ? .secondary : .primary)
                }

                Section("Joining Date") {
                    Text(employee.joiningDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")
                        .foregroundStyle(employee.joiningDate == nil ? .secondary : .primary)
                }
            }
            .listSectionSpacing(.compact)
            .navigationTitle("Details")

            .navigationDestination(isPresented: $goToPfp){
                PfpView(imgUrl: employee.imgURL ?? "", size: 80)
            }
        }
    }
}


#Preview {
    // Testing data for preview.
    EmployeeDetailsView(employee: Employee(id: "dl806", name: "Sunil asadf", designation: "ios", department: "ios", isActive: true, imgURL: "", email: "abc@gmail", city: "gzb", country: "india", joiningDate: Date.now))
}
