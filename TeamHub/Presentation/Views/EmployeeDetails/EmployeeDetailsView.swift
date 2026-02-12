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

    var body: some View {

        ZStack {

            // MARK: - Main Content
            List {
                Section {
                    HStack(spacing: 14) {

                        EmployeeAvatarView(imgURL: employee.imgURL, size: 80)
                            .matchedGeometryEffect(id: "employee_avatar_\(employee.id)", in: avatarNamespace)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                    showAvatarViewer = true
                                }
                            }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(employee.name)
                                .font(.title3.bold())

                            Text(employee.designation)
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)

                            Text(employee.department)
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.vertical, 8)
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

                Section("Employee Status") {
                    Text(employee.isActive ? "Active" : "Inactive")
                        .foregroundStyle(employee.isActive ? .green : .red)
                }
            }
            .navigationTitle("Details")
            .disabled(showAvatarViewer)

            // MARK: - Overlay (MUST be inside ZStack)
            if showAvatarViewer {
                AvatarOverlayViewer(
                    employee: employee,
                    namespace: avatarNamespace,
                    isPresented: $showAvatarViewer
                )
//                .transition(.opacity)
                .zIndex(999)
            }
        }
    }
}
