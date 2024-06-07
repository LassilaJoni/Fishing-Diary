//
//  AddFish.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 6.8.2022.
//

import SwiftUI
import CoreData
import MapKit
import CoreLocationUI

struct AddFish: View {
    //@Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            
                GeometryReader { geometry in
                    ZStack {
                        LinearGradient(gradient: .init(colors: [Color("Color-dark-1"), Color("Color-dark-3")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
                        
                        Home(dismissSheet: dismissSheet)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            
        }
    public func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
    }
    }

struct AddFish_Previews: PreviewProvider {
    static var previews: some View {
        AddFish()
    }
    
}

struct Home : View {
    
    
    @State var image: Data = .init(count: 0)
    var dismissSheet: () -> Void
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                
                Add(dismissSheet: dismissSheet)
            }
            .frame(width: geometry.size.width)
        }
        }
       
        
        
        
        
        
        
        
        
    }
}

struct Add: View {
    
    @State private var title: String = ""
    @State private var details: String = ""
    @State private var weight: String = ""
    @State private var showSheet: Bool = false
    
    @State private var image: Data = .init(count: 0)
    
    @State private var showImageSourceSheet: Bool = false
    
    @ObservedObject var locationManager = LocationManager.shared
    
    @State private var region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    
    @State var tracking:MapUserTrackingMode = .follow
    
    var dismissSheet: () -> Void
    @State private var navigateToMainPage: Bool = false
    //@Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    //CORE DATA
    @Environment(\.managedObjectContext) private var moc
    //@Environment(\.dismiss) private var dismiss
    
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    
    
    let radius: CGFloat = 100
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    
    
    private func updateMapView() {
        locationManager.requestLocation()
        region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
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
                                Button(action: {
                                    //Might fix the bug when user reselects an image it doesn't close the sheet when saving the fish
                                    //self.image.count = 0
                                    self.showSheet.toggle()}) {
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
                            .fullScreenCover(isPresented: self.$showSheet) {
                                ImagePicker(show: self.$showSheet, image: self.$image, sourceType: imagePickerSource)
                            }
                            
                    }
                } else {
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                            //  self.showSheet.toggle()
                            self.showImageSourceSheet.toggle()
                            
                        }
                        
                    }) {
                        
                        Text("Add image")
                            .foregroundColor(Color("Color-dark-1"))
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                        
                    }
                    
                    .actionSheet(isPresented: $showImageSourceSheet) {
                        ActionSheet(title: Text("Choose Image Source"), message: nil, buttons: [
                            .default(Text("Camera")) {
                                self.imagePickerSource = .camera
                                self.showSheet = true
                                
                            },
                            .default(Text("Photo Library")) {
                                self.imagePickerSource = .photoLibrary
                                self.showSheet = true
                            },
                            .cancel()
                        ])
                    } .fullScreenCover(isPresented: self.$showSheet) {
                        ImagePicker(show: self.$showSheet, image: self.$image, sourceType: imagePickerSource)
                    }
                    .background(Color("Color-dark-2"))
                    .clipShape(Capsule())
                }
                
            }
            .padding(.vertical, 20)
            
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .foregroundColor(Color("Color-dark-2"))
                    
                    TextField("", text: self.$title, prompt: Text("Enter catch name...")
                        .foregroundStyle(.gray))
                        .foregroundColor(.black)
                }.padding(.vertical, 20)
                
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "note.text")
                        .foregroundColor(Color("Color-dark-2"))
                    
                    TextField("", text: self.$details, prompt: Text("Enter notes about catch...")
                        .foregroundStyle(.gray))
                        .foregroundColor(.black)
                        
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "scalemass.fill")
                        .foregroundColor(Color("Color-dark-2"))
                    
                    TextField("", text: self.$weight, prompt: Text("E.g 7 kg or 15 lb")
                        .foregroundStyle(.gray))
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                Divider()
                Group {
                    HeadingView(headingImage: "map.fill", headingText: "Add location", headingTextColor: "Color-dark-1")
                    
                    
                    ZStack {
                        
                        Map(coordinateRegion: $region,
                            interactionModes: .all,
                            showsUserLocation: true,
                            userTrackingMode: $tracking)
                        .onAppear(perform: updateMapView)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                        .cornerRadius(20)
                        Cross().stroke(Color.red)
                            .frame(width: 50, height: 50)
                        VStack {
                            Spacer()
                            
                            
                            
                            
                        }
                        
                    }
                    LocationButton {
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: LocationManager.currentLocation, span: span)
                        self.region = region
                    }
                    .frame(width: 180, height: 40)
                    .cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    Text("lat: \(region.center.latitude), long: \(region.center.longitude)")
                        .foregroundColor(Color.black)
                }
            }
            .ignoresSafeArea(.keyboard)
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("Color4")]), startPoint: .leading, endPoint: .bottom)
            )
           // .frame(width: UIScreen.main.bounds.width - 20)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
                Button(action: {
                    let save = Fish(context: self.moc)
                    
                    save.imageData = image
                    save.title = self.title
                    save.details = self.details
                    save.weight = self.weight
                    save.timestamp = Date()
                    save.lat = region.center.latitude
                    save.long = region.center.longitude
                    save.id = UUID()
                    
                    do {
                        try self.moc.save()
                        dismissSheet()
                    }catch {
                        print("Error in saving data")
                    }
                    
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
                .disabled(self.image.isEmpty || self.title.isEmpty || self.details.isEmpty)
            .background((self.title.count > 0 && self.details.count > 0 && self.image.count > 0) ? LinearGradient(gradient: .init(colors: [Color("Color-dark-2"),Color("Color-dark-2")]), startPoint: .leading, endPoint: .trailing):
                            //If empty
                        LinearGradient(gradient: .init(colors: [Color("Color-dark-1"),Color("Color-dark-3")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 15)
            
        } //: VSTACK
        
    }
    
    
    
    
    
}


// Cross for the map

struct Cross: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        }
    }
}

