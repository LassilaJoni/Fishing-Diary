
//  ContentView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.


import SwiftUI
import CoreData
import MapKit

struct ContentView: View {
    @State private var selectedIndex = 0
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
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
        GeometryReader { geometry in
            NavigationView {
                LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4"),Color("Color-List-Outside-5")]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            
                            List {
                                
                                ForEach(fishes, id: \.id) { fish in
                                    NavigationLink(destination: FishDetailView(fish: fish)) {
                                        FishListItemView(fish: fish)
                                    }
                                }
                                
                                
                                .listRowBackground(LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-5"),Color("Color-List-Outside-4"),Color("Color-List-Outside-3"),Color("Color-List-Outside-2"),Color("Color-List-Outside-1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
                                
                            } //: LIST
                            .listStyle(.plain)
                            
                            
                            NavigationBarView()
                            
                                .navigationTitle("Fishing Diary")
                                .preferredColorScheme(.dark)
                        }
                    )
                
                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(action: {
//                                self.showSheet.toggle()
//                            }) {
//                                Image(systemName: "plus")
//                            }
//                        }
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
                
                    .foregroundColor(Color.white)
                    .sheet(isPresented: self.$showSheet) {
                        AddFish().environment(\.managedObjectContext, self.viewContext)
                    }
                
            } //:NAVIGATION
            .navigationViewStyle(StackNavigationViewStyle())
            
            
            
            
            
        } //: GEOMETRY
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    var body: some View {
//        CustomTabView()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//
//    }
//}
//
//
//struct Main: View {
//
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//       }
//
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State private var showSheet: Bool = false
//
//    @FetchRequest(
//    sortDescriptors: [
//        NSSortDescriptor(keyPath: \Fish.timestamp, ascending: false),
//
//    ],
//    animation: .default)
//    private var fishes: FetchedResults<Fish>
//
//    @State private var image: Data = .init(count: 0)
//
//    var body: some View {
//        GeometryReader { geometry in
//        NavigationView{
//            LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4"),Color("Color-List-Outside-5")]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
//                .overlay(
//
//                    List {
//                ForEach(fishes, id: \.id) { fish in
//                    NavigationLink(destination: FishDetailView(fish: fish)) {
//                        FishListItemView(fish: fish)
//                    }
//                }
//
//
//               .listRowBackground(LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-5"),Color("Color-List-Outside-4"),Color("Color-List-Outside-3"),Color("Color-List-Outside-2"),Color("Color-List-Outside-1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
//
//            } //: LIST
//                .listStyle(.plain)
//                //.cornerRadius(30)
//
//
//
//            .navigationTitle("Fishing Diary") //:NAVIGATION
//                .preferredColorScheme(.dark)
//
//            )
//
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        self.showSheet.toggle()
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        self.showSheet.toggle()
//                    }) {
//                        Image(systemName: "gear")
//                    }
//                }
//            }
//            .foregroundColor(Color.white)
//            .sheet(isPresented: self.$showSheet) {
//                AddFish().environment(\.managedObjectContext, self.viewContext)
//            }
//
//        }
//}
//
//    }
//}
//
////struct ContentView_Previews: PreviewProvider {
////    static var previews: some View {
////        Main().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
////    }
////}
//
//struct CustomTabView : View {
//
//    @State var isPresenting = false
//        @State private var selectedItem = 1
//        @State private var oldSelectedItem = 1
//
//    @State var selectedTab = "house"
//    @State private var showSheet: Bool = false
//    @Environment(\.managedObjectContext) private var viewContext
//
//    var body: some View {
//        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
//            Main()
//
//            TabView(selection: $selectedTab) {
//                Main()
//                    .tag("house")
////                AddFish()
////                    .onTapGesture {
////                    showSheet.toggle()
////                    }
////                    .tag("plus")
//
//                .tag("plus")
//                MapMainView()
//                    .tag("map")
//
//
//            }
//            .sheet(isPresented: self.$showSheet, content: {
//                AddFish().environment(\.managedObjectContext, self.viewContext)
//            })
//
//
//
//            HStack(spacing: 0) {
//                ForEach(tabs, id: \.self) {image in
//                    TabButton(image: image, selectedTab: $selectedTab)
//
//                    if image != tabs.last {
//                        Spacer(minLength: 0)
//                    }
//                }
//            } //: HSTACK
//            .padding(.horizontal, 25)
//            .padding(.vertical, 5)
//            .background(Color.white)
//            .clipShape(Capsule())
//            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
//            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: -5)
//            .padding(.horizontal)
//
//        }
//    }
//}
//
//var tabs = ["house","plus","map"]
//
//struct TabButton : View {
//    var image : String
//    @Binding var selectedTab : String
//
//    var body: some View {
//        Button(action: {selectedTab = image}) {
//            Image(systemName: image)
//                .renderingMode(.template)
//                .foregroundColor(selectedTab == image ? Color.black : Color.black.opacity(0.4))
//                .padding()
//        }
//    }
//}
//
//
//
