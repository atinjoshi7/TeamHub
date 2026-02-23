//
//  PfpView.swift
//  TeamHub
//
//  Created by Jarvis on 16/02/26.
//

import SwiftUI
import Kingfisher

struct PfpView: View{
    let imgUrl: String
    let size: CGFloat
    @Environment( \.dismiss) private var dismiss
    @State private var loadFailed: Bool = false
    var body: some View{
        
        ZStack{
            if let url = URL(string: imgUrl), loadFailed == false{
                
                
                KFImage(url)
                    .onFailure{ _ in
                        loadFailed = true
                    }
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 35)
                    .scaleEffect(1.2)
                    .overlay(
                        Color.black.opacity(0.35)
                            .ignoresSafeArea()
                    )
                
                VStack{
                    
                    Spacer()
                    KFImage(URL(string: imgUrl))
                        .onFailure { _ in
                            loadFailed = true
                        }
                    
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 320)
                        .clipShape(Circle())
                        .shadow(radius: 25)
                    Spacer()
                }
            }
            else{
                // Clean fallback
                Color.gray
                    .ignoresSafeArea()
                VStack{
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 100))
                        .foregroundStyle(.black)
                    
                    Text("No Profile Image")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
