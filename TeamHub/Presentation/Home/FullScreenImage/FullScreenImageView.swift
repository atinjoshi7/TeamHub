//
//  FullScreenImageView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

//import SwiftUI
//import Kingfisher
//
//struct FullScreenImageView: View {
//    
//    let url: String?
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        
//        ZStack{
//            Color.black.ignoresSafeArea()
//            
//            content
//                .padding()
//        }
////        .overlay(alignment: .topTrailing){
////            Button {
////                dismiss()
////            } label: {
////                Image(systemName: "xmark.circle.fill")
////                    .font(.system(size: 28))
////                    .foregroundStyle(.white.opacity(0.9))
////                    .padding()
////            }
////        }
//    }
//    
//    @ViewBuilder
//    var content: some View{
//        
//        let urlString = url?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//        
//        let url = URL(string: urlString)
//        
//        if urlString.isEmpty || url == nil{
//            Image(systemName: "person")
//                          .resizable()
//                          .scaledToFit()
//                          .foregroundStyle(.white.opacity(0.8))
//                          .padding(40)
//        }else{
//            KFImage(url)
//                .placeholder{
//                    ProgressView()
//                        .tint(.white)
//                }
//                .resizable()
//                .scaledToFit()
//        }
//    }
//}
//
