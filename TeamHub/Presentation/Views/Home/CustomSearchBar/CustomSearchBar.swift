//
//  CustomSearchBar.swift
//  TeamHub
//
//  Created by Jarvis on 17/02/26.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @Binding var text: String
    var placeHolder: String = "Search"
    var isFocused: FocusState<Bool>.Binding
    var body: some View {
        HStack(spacing:10){
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField(placeHolder, text: $text)
                .focused(isFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            
            
            if text.isEmpty == false{
                Button{
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(Color.secondary.opacity(0.4), lineWidth: 1.5)
        )
        .padding(.horizontal)
        .padding(.top, 8)
    }
}


