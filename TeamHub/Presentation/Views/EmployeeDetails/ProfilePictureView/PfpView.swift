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
    
    var body: some View{
        
        ZStack{
            KFImage(URL(string: imgUrl))
                .placeholder{
                    
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
                    .placeholder{
                        Text("No profile image")
                     }
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320)
                    .clipShape(Circle())
                    .shadow(radius: 25)
                Spacer()
            }
        }
    }
}
