//
//  AddFish.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 6.8.2022.
//

import SwiftUI
import CoreData
import MapKit

struct AddFish: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            
            if UIScreen.main.bounds.height > 800{
                ScrollView(.vertical, showsIndicators: false) {
                Home()
                }
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    Home()
                }
            }
            
        } //:ZSTACK
        
    } //:BODY
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
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
    
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        
        
        VStack{
            
            
            
            Add()
            
            
            
        }
        .padding()
        
        
    }
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct Add: View {
    
    @State private var title: String = ""
    @State private var details: String = ""
    @State private var specie: String = ""
    @State private var weight: String = ""
    @State private var showSheet: Bool = false
    
    @State private var image: Data = .init(count: 0)
    
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude),
            span: MKCoordinateSpan(latitudeDelta: MapDefaults.zoom, longitudeDelta: MapDefaults.zoom))
    
    private enum MapDefaults {
         static let latitude = 45.872
         static let longitude = -1.248
         static let zoom = 0.5
     }
    
    @Environment(\.presentationMode) var presentationMode
    //CORE DATA
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    
    var saveLocationMapView: SaveLocationMapView
    
      init() {
          self.saveLocationMapView = SaveLocationMapView()
         
      }
 
    
    
    let radius: CGFloat = 100
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    
    var body : some View{
        
    
        
        VStack{
            HStack{
                
                if self.image.count != 0 {
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Image(uiImage: UIImage(data: self.image)!)
                            .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: radius * 2,
                                        height: radius * 2)
                                    .clipShape(Circle())
                            .overlay(
                                Button(action: { self.showSheet.toggle()}) {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .background(Color.gray)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }.offset(x: offset, y: offset))
                            .sheet(isPresented: self.$showSheet) {
                                ImagePicker(show: self.$showSheet, image: self.$image)
                            }
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
                
            }
               
                
            
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
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .foregroundColor(.accentColor)
                    
                    TextField("Enter specie...", text: self.$specie)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "scalemass.fill")
                        .foregroundColor(.accentColor)
                    
                    TextField("E.g 7 kg or 15 lb", text: self.$weight)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                HStack(spacing: 15){
                    
                    Map(coordinateRegion: $region,
                                    interactionModes: .all,
                                    showsUserLocation: true)
                        .frame(width: 350, height: 250)
                    
                }.padding(.vertical, 20)
                
                Text("lat: \(region.center.latitude), long: \(region.center.longitude). Zoom: \(region.span.latitudeDelta)")
            }
            .ignoresSafeArea(.keyboard)
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(
                    LinearGradient(gradient: Gradient(colors: [Color("Color-List-1"),Color("Color-List-2"),Color("Color-List-3"),Color("Color-List-5")]), startPoint: .leading, endPoint: .bottom)
                )
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                let save = Fish(context: self.moc)
                
                save.imageData = image
                save.title = self.title
                save.details = self.details
                save.specie = self.specie
                save.weight = self.weight
                save.timestamp = Date()
                save.lat = region.center.latitude
                save.long = region.center.longitude
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
            }
            
            /*.background(
             
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
    
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
}
