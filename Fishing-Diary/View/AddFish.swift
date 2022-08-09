//
//  AddFish.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 6.8.2022.
//

import SwiftUI
import CoreData

struct AddFish: View {
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: .init(colors: [Color("Color1"),Color("Color2"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            if UIScreen.main.bounds.height > 800{
                
                Home()
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    Home()
                }
            }
        }
    }
}

struct AddFish_Previews: PreviewProvider {
    static var previews: some View {
        AddFish()
    }
}
/*
 withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
 */
struct Home : View {
    

    @State var image: Data = .init(count: 0)

    
    var body : some View{
        
        VStack{
            
            Image("fish")
            .resizable()
            .frame(width: 200, height: 180)
            
            Add()
            
            
            
        }
        .padding()
    }
}

struct Add : View {
    
    @State private var title: String = ""
    @State private var details: String = ""
    @State private var showSheet: Bool = false
    
    @State private var image: Data = .init(count: 0)
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    var body : some View{
        
        VStack{
            HStack{
                
                if self.image.count != 0 {
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Image(uiImage: UIImage(data: self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .shadow(radius: 8)
                    }
                } else {
                
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                    self.showSheet.toggle()
                    

                    }
                    
                }) {
                    
                    Text("Add image")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }
                
                .sheet(isPresented: self.$showSheet) {
                    ImagePicker(show: self.$showSheet, image: self.$image)
                }
                .background(Color.white)
                .clipShape(Capsule())
                }
               
            } .background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .foregroundColor(.accentColor)
                    
                    TextField("Enter title...", text: self.$title)
                        .preferredColorScheme(.light)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .foregroundColor(.accentColor)
                    
                    TextField("Enter description...", text: self.$details)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                let save = Fish(context: self.moc)
                
                save.imageData = image
                save.title = self.title
                save.details = self.details
                save.timestamp = Date()
                save.id = UUID()
                // TODO: ERROR HANDLING
                
                try! self.moc.save()
               
                self.title = ""
                self.details = ""
                
                dismiss()
            }) {
                if self.title.isEmpty || self.details.isEmpty || self.image.isEmpty {
                    VStack {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    Text("Please fill all the fields")
                            .foregroundColor(.red)
                            .font(.footnote)
                           .padding(.bottom, 3)
                           .padding(.top, -20)
                    }
                    
                } else {
                Text("SAVE")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                }
            }/*.background(
            
                LinearGradient(gradient: .init(colors: [Color("Color1"),Color("Color2"),Color("Color1")]), startPoint: .leading, endPoint: .trailing)
            )*/
            //If not empty
            .background((self.title.count > 0 && self.details.count > 0 && self.image.count > 0) ? LinearGradient(gradient: .init(colors: [Color("Color1"),Color("Color2"),Color("Color1")]), startPoint: .leading, endPoint: .trailing):
                //If empty
                LinearGradient(gradient: .init(colors: [Color(.gray)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 15)
        }
    }
}


