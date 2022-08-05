//
//  AddFishView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI
import CoreData
import Photos

struct AddFishView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var details: String = ""
    @State private var image: Data = .init(count: 0)
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
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
                        self.showSheet.toggle()
                    }) {
                        Text("Select a image")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 2)
                    }
                    .background(Color.blue)
                    .clipShape(Capsule())
                    
                }
            

                VStack(alignment: .leading) {
                                //Text("Outlined Custom TextField Style").font(.title2)
                                HStack {
                                    Image(systemName: "")
                                    TextField("Title...", text: self.$title)
                                }.modifier(customViewModifier(roundedCornes: 6, backgroundColor: .white, textColor: .gray, strokeColor: .blue) )
                    HStack {
                        Image(systemName: "")
                        TextField("Description...", text: self.$details)
                    }.modifier(customViewModifier(roundedCornes: 6, backgroundColor: .white, textColor: .gray, strokeColor: .blue) )
                            }.padding()
                

                
                Button(action: {
                    
                 
                    
                    let save = Fish(context: self.moc)
                    
                    save.imageData = self.image
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
                    
                    Text("Save")
                }
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.pink)
                .cornerRadius(10)
                
            }//: VSTACK
        }//: NAVIGATION
        .sheet(isPresented: self.$showSheet) {
            ImagePicker(show: self.$showSheet, image: self.$image)
        }
    }
    
}





struct AddFishView_Previews: PreviewProvider {
    static var previews: some View {
        AddFishView()
    }
}

//: CUSTOM TEXTFIELD STYLE
struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var backgroundColor: Color
    var textColor: Color
    var strokeColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                .stroke(strokeColor))
            .font(.custom("Open Sans", size: 18))
            
            .shadow(radius: 10)
    }
}
