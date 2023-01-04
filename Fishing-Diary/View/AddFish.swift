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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
                    ZStack {
                        LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            Home()
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button(action: dismissSheet, label: {
                                Circle()
                                    .fill(Color(.secondarySystemBackground))
                                    .frame(width: 40, height: 30) // You can make this whatever size, but keep UX in mind.
                                    .overlay(
                                        Image(systemName: "xmark")
                                            .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                            .foregroundColor(.secondary)
                                    )
                            })
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(Text("Close"))
                        }
                    }
                } //: NavigationView
  
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

struct Home : View {
    
    
    @State var image: Data = .init(count: 0)
    
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        
        
        VStack(alignment: .center) {
            
            Add()
            
        }
        
        
        
        
        
        
        
    }
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
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
    
    
    
    @Environment(\.presentationMode) var presentationMode
    //CORE DATA
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
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
                            .foregroundColor(.black)
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
                    }.sheet(isPresented: self.$showSheet) {
                        ImagePicker(show: self.$showSheet, image: self.$image, sourceType: imagePickerSource)
                    }
                    .background(Color("Color4"))
                    .clipShape(Capsule())
                }
                
            }
            .padding(.vertical, 20)
            
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .foregroundColor(.accentColor)
                    
                    TextField("Enter catch name...", text: self.$title)
                        .preferredColorScheme(.light)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "note.text")
                        .foregroundColor(.accentColor)
                    
                    TextField("Enter notes about catch...", text: self.$details)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "scalemass.fill")
                        .foregroundColor(.accentColor)
                    
                    TextField("E.g 7 kg or 15 lb", text: self.$weight)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                Divider()
                Group {
                    HeadingView(headingImage: "map.fill", headingText: "Add location", headingTextColor: "Color1")
                    
                    
                    ZStack {
                        
                        Map(coordinateRegion: $region,
                            interactionModes: .all,
                            showsUserLocation: true,
                            userTrackingMode: $tracking)
                        .onAppear(perform: updateMapView)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 400)
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
            .frame(width: UIScreen.main.bounds.width - 10)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                let save = Fish(context: self.moc)
                
                save.imageData = image
                save.title = self.title
                save.details = self.details
                // save.specie = self.specie
                save.weight = self.weight
                save.timestamp = Date()
                save.lat = region.center.latitude
                save.long = region.center.longitude
                save.id = UUID()
                // TODO: ERROR HANDLING
                
                do {
                    try self.moc.save()
                    //self.title = ""
                    //self.details = ""
                }catch {
                    print("Error in saving data")
                }
                
                
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
            .disabled(self.image.isEmpty || self.title.isEmpty || self.details.isEmpty || self.weight.isEmpty)
            .background((self.title.count > 0 && self.details.count > 0 && self.image.count > 0) ? LinearGradient(gradient: .init(colors: [Color("Color1"),Color("Color2"),Color("Color1")]), startPoint: .leading, endPoint: .trailing):
                            //If empty
                        LinearGradient(gradient: .init(colors: [Color(.gray)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 15)
            
        } //: VSTACK
        
    }
    
    private func dismissSheet() {
        presentationMode.wrappedValue.dismiss()
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

