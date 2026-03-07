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
    @State private var loadFailed: Bool = false
    
    
    /* Responsible for showing the enlarged image of the user */
    var body: some View{
        
        ZStack{

            if let url = URL(string: imgUrl), loadFailed == false{
                
                /* This is the blurred background image of user. */
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
                    /* This is the image of the user, placed in the center */
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
        }
    }
}
