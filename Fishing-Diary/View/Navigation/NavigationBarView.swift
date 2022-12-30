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
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body : some View {
          
              
              VStack {
                 
                  
                  HStack {
                      Button(action: {
                          self.index = 0
                      }) {
                          Image(systemName: "homekit")
                              .font(.system(size: 30))
                      }
                      .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.2))

                      Spacer(minLength: 0)

                      Button(action: {
                          self.index = 1
                          self.showSheet.toggle()
                      }) {
                          Image(systemName: "plus.circle.fill")
                              .font(.system(size: 45))
                              .foregroundColor(Color("Color1"))
                      }
                      .offset(y: -25)

                      Spacer(minLength: 0)

                      Button(action: {
                          self.index = 2
                      }) {
                          Image(systemName: "map")
                              .font(.system(size: 30))
                      }
                      .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.2))
                  }
                  .sheet(isPresented: self.$showSheet) {
                      AddFish().environment(\.managedObjectContext, self.viewContext)
                  }
                  .padding(.horizontal, 75)
                  .background(Color.white)
              }
               // set the frame to the width of the screen and a fixed height
          
      }
  }
