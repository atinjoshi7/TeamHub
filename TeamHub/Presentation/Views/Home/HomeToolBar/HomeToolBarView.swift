////
////  HomeToolBar.swift
////  TeamHub
////
////  Created by Jarvis on 23/02/26.
////
//
import SwiftUI

struct HomeToolBarView: ToolbarContent{
    
    @Binding var showFilterSheet: Bool
    let filter: EmployeeFilter
    let isSearchFocused: () -> Void
    
    @EnvironmentObject private var themeManager: ThemeManager
    var body: some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing){
            Button{
                showFilterSheet = true
                 isSearchFocused()
            } label: {
                HStack{
                    Image(systemName: "slider.horizontal.3")
                    if filter.totalCount != 0{
                        Text("\(filter.totalCount)")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            }
            
        }
        ToolbarItem(placement: .topBarTrailing){
            Button{
                withAnimation(.easeInOut(duration: 0.25)){
                    themeManager.isDarkMode.toggle()
                }
            } label:{
                Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                    .font(.system(size: 18, weight: .medium))
            }
        }
    }
}
