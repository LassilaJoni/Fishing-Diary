//
//  NavigationBarView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 30.12.2022.
//


// TODO: Refactor code, navigation bar is inside too many stacks. It was for testing purposes and testing was really succesful :)
import SwiftUI

struct NavigationBarView: View {
    @State var index = 0
    
    var body: some View {
        
        
        
        VStack {
            CustomTabs(index: self.$index)
               
        }

        
    }
    
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
        
    }
        
}


struct CustomTabs : View {
    
    @Binding var index : Int
    
    @State private var showSheet: Bool = false
    
    @State private var showMapSheet: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body : some View {
        
        VStack {
            
            HStack {
                Button(action: {
                    self.index = 0
                }) {
                    VStack {
                   
                    Image(systemName: "house")
                        .font(.system(size: 25))
                        Text("Home")
                    }
                }
                
                .foregroundColor(Color.white.opacity(self.index == 0 ? 1 : 0.2))
                
                Spacer(minLength: 0)
                
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    
                    ZStack {
                        Image(systemName: "plus")
                            .font(.system(size: 45))
                            .foregroundColor(Color.white)
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 45))
                            .foregroundColor(Color("Color-1"))
                            .shadow(color: .white, radius: 2, x: 0, y: 2)
                        
                    }
                    
                    .offset(y: -5)
                }
                
                Spacer(minLength: 0)
                
                
                
                NavigationLink(destination: MapMainView()) {
             
                        VStack {
                            Image(systemName: "map")
                                .font(.system(size: 25))
                            Text("Map")
                        }
                }
               .foregroundColor(Color.white.opacity(self.index == 1 ? 1 : 0.2))
            }
            .fullScreenCover(isPresented: self.$showSheet) {
                AddFish().environment(\.managedObjectContext, self.viewContext)
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 5)
            .frame(width: 350)
            
        }

        .background(Color("Color-1"))
        .clipShape(Capsule())
   
        
    }
        
       
        
        
        
}
