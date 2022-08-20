//
//  ContentView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
           UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = .clear

       }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showSheet: Bool = false

    @FetchRequest(
    sortDescriptors: [
        NSSortDescriptor(keyPath: \Fish.timestamp, ascending: false),
        //NSSortDescriptor(keyPath: \Fish.title, ascending: true)
        
    ],
    animation: .default)
    private var fishes: FetchedResults<Fish>
    
    @State private var image: Data = .init(count: 0)
    
    var body: some View {
        
        NavigationView {
            LinearGradient(gradient: .init(colors: [Color("Color-1"),Color("Color4"),Color("Color-1")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                .overlay(
            List {
          
                ForEach(fishes, id: \.id) { fish in
                    NavigationLink(destination: FishDetailView(fish: fish)) {
                        FishListItemView(fish: fish)
                    }
                    
                }
                
                
               .listRowBackground(LinearGradient(gradient: .init(colors: [Color("Color-1"),Color("Color4"),Color("Color-1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
                //.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            } //: LIST
                .listStyle(.plain)

                
                
            .navigationTitle("Fishes") //:NAVIGATION
                .preferredColorScheme(.light)
            )
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: self.$showSheet) {
                AddFish().environment(\.managedObjectContext, self.viewContext)
            }
        }
        
}
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



