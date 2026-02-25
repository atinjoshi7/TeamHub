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
    @State private var showAvatarViewer: Bool = false
    @Namespace private var avatarNamespace
    @State private var goToPfp = false
    @State private var canOpenpfp = false
    var body: some View {

        ZStack {

            // Main Content
            List {
                Section {
                    HStack(spacing: 14) {

                        EmployeeAvatarView(
                            imgURL: employee.imgURL,
                            size: 80,
                            onImageLoadSuccess: {
                                canOpenpfp = true
                                
                            },
                            onImageLoadFailure:{
                                canOpenpfp = false
                            }
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
                        Text(employee.isActive ? "Active" : "InActive")
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
            .disabled(showAvatarViewer)
            .navigationDestination(isPresented: $goToPfp){
                PfpView(imgUrl: employee.imgURL ?? "", size: 80)
            }
             
            // Mark: - Overlay (MUST be inside ZStack)
            if showAvatarViewer {
                AvatarOverlayViewer(
                    employee: employee,
                    namespace: avatarNamespace,
                    isPresented: $showAvatarViewer
                )
                .zIndex(999)
            }
        }
    }
}

#Preview {
    EmployeeDetailsView(employee: Employee(id: "dl806", name: "Sunil asadf", designation: "ios", department: "ios", isActive: true, imgURL: "", email: "abc@gmail", city: "gzb", country: "india", joiningDate: Date.now))
}
