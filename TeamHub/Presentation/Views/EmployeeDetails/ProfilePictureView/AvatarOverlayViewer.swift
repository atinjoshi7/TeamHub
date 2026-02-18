//
//  AvatarOverlayViewer.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI

struct AvatarOverlayViewer: View {

    let employee: Employee
    let namespace: Namespace.ID
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {

            Rectangle()
//                .fill(.black.opacity(0.35))
//                .ignoresSafeArea()
//                .background(.ultraThinMaterial)
                .onTapGesture {
                    dismiss()
                }

            EmployeeAvatarView(imgURL: employee.imgURL, size: 260)
                .matchedGeometryEffect(id: "employee_avatar_\(employee.id)", in: namespace)
                .shadow(radius: 18)
        }
//        .transition(.opacity)
        .zIndex(999)
    }
    private func dismiss() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isPresented = false
        }
    }
}

