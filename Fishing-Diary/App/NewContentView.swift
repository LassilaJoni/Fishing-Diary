
//  ContentView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.


import SwiftUI
import CoreData
import MapKit
import UIKit

struct NewContentView: View {
    @State private var selectedTab: Tabs = .home
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.shadowImage = UIImage()
        
        UIToolbar.appearance().barTintColor = UIColor.clear
        UIToolbar.appearance().isTranslucent = true
        UIToolbar.appearance().backgroundColor = .clear
        
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showSheet: Bool = false
    @State private var showSettingsSheet: Bool = false
       
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Fish.timestamp, ascending: false),
            
        ],
        animation: .default)
    private var fishes: FetchedResults<Fish>
    
    @State private var image: Data = .init(count: 0)
    
    var body: some View {
            NavigationView {
                LinearGradient(gradient: .init(colors: [Color("Color-dark-1")]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            
                            List {
                                
                                ForEach(fishes, id: \.id) { fish in
                                    NavigationLink(destination: FishDetailView(fish: fish)) {
                                        FishListItemView(fish: fish)
                                    }
                                }
                                .listRowBackground(LinearGradient(gradient: .init(colors: [Color("Color-dark-1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
                                
                                /*.listRowBackground(LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-5"),Color("Color-List-Outside-4"),Color("Color-List-Outside-3"),Color("Color-List-Outside-2"),Color("Color-List-Outside-1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
                                */
                            } //: LIST
                            .listStyle(.plain)
                            BottomNavigationBarView(selectedTab: $selectedTab)
                                    .navigationTitle("Fishing Diary")
                            
                                
                                
                        }
                    )
                
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button(action: {
                                self.showSettingsSheet.toggle()
                            }) {
                                Image(systemName: "gear")
                            }.sheet(isPresented: $showSettingsSheet) {
                                SettingsView()
                            }
                        }
                        
                    }
                    .foregroundStyle(Color.accentColor)
                    
                
                    
                    .sheet(isPresented: self.$showSheet) {
                        AddFish().environment(\.managedObjectContext, self.viewContext)
                    }
                
            } //:NAVIGATION
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct NewContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


