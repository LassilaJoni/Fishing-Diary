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
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

       }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showSheet: Bool = false

    @FetchRequest(
    sortDescriptors: [
        NSSortDescriptor(keyPath: \Fish.timestamp, ascending: false),
        
    ],
    animation: .default)
    private var fishes: FetchedResults<Fish>
    
    @State private var image: Data = .init(count: 0)
    
    var body: some View {
        GeometryReader { geometry in
        NavigationView{
            LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4"),Color("Color-List-Outside-5")]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                .overlay(
                   
                    List {
                ForEach(fishes, id: \.id) { fish in
                    NavigationLink(destination: FishDetailView(fish: fish)) {
                        FishListItemView(fish: fish)
                    }
                }
                
                
               .listRowBackground(LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-5"),Color("Color-List-Outside-4"),Color("Color-List-Outside-3"),Color("Color-List-Outside-2"),Color("Color-List-Outside-1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
               
            } //: LIST
                .listStyle(.plain)
                //.cornerRadius(30)
                
                
                
            .navigationTitle("Fishing Diary") //:NAVIGATION
                .preferredColorScheme(.dark)
            
            )
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .foregroundColor(Color.white)
            .sheet(isPresented: self.$showSheet) {
                AddFish().environment(\.managedObjectContext, self.viewContext)
            }
        }
        
        
}
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



