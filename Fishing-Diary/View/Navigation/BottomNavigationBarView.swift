//
//  BottomNavigationBarView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.1.2024.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case map = 1
}

struct BottomNavigationBarView: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Button {
                selectedTab = .home
            } label: {
                
                
                GeometryReader { geo in
                    if selectedTab == .home {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width / 2, height: 4)
                            .padding(.leading, geo.size.width / 4)
                    }
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Home")
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .tint(.gray)
            
            
                NavigationLink(destination: AddFish()) {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .accessibilityIdentifier("add fish")
                        Text("New Catch")
                    }
                    
                }
            

            
            NavigationLink(destination: MapMainView()) {
         
                GeometryReader { geo in
                    if selectedTab == .map {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width / 2, height: 4)
                            .padding(.leading, geo.size.width / 4)
                    }
                    VStack(alignment: .center, spacing: 4){
                        Image(systemName: "map")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Map")
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
        }
        .frame(height: 82)

    }
}

#Preview {
    BottomNavigationBarView(selectedTab: .constant(.home))
}
