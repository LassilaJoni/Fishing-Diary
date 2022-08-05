//
//  ContentView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showSheet: Bool = false

    @FetchRequest(
    sortDescriptors: [
        NSSortDescriptor(keyPath: \Fish.id, ascending: true),
        NSSortDescriptor(keyPath: \Fish.title, ascending: true)
        
    ],
    animation: .default)
    private var fishes: FetchedResults<Fish>
    
    @State private var image: Data = .init(count: 0)
    
    var body: some View {
        NavigationView {
            List {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(fishes, id: \.id) { fish in
                    NavigationLink(destination: FishDetailView(fish: fish)) {
                        FishItemListView(fish: fish)
                    }
                    
                }
            }
            } //: SCROLLVIEW
            .navigationTitle("Fishes") //:NAVIGATION
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
                AddFishView().environment(\.managedObjectContext, self.viewContext)
            }
        }
        
}
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
