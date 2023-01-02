//
//  FishDetailView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI
import CoreData
import MapKit

struct FishDetailView: View {
    
    let fish: Fish
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        

        ScrollView(.vertical) {
            Detail(fish: fish)
        }
                
        .edgesIgnoringSafeArea(.all)
            

    }
    
}

struct FishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFish
        FishDetailView(fish: fish)
    }
}

extension NSManagedObjectContext {
    var firstFish: Fish {
        let fetchRequest = Fish.fetchRequest()
        fetchRequest.fetchLimit = 1
        let result = try! fetch(fetchRequest)
        return result.first!
    }
}

struct FishAnnotation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct Detail: View {
    
    
    @Environment(\.managedObjectContext) private var moc
    @State var image : Data = .init(count: 0)
    @State private var isShowingDialog = false
    
    let fish: Fish
    let annotations: [FishAnnotation]
    @State private var region: MKCoordinateRegion
    
    init(fish: Fish) {
           self.fish = fish
           self.annotations = [
            FishAnnotation(name: fish.title ?? "No data found", coordinate: CLLocationCoordinate2D(latitude: fish.lat, longitude: fish.long)),
           ]

           self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: fish.lat, longitude: fish.long),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
       }
    
    var body: some View {
        
        VStack {
            VStack {
                NavigationLink(destination: InsetImageView(fish: fish)) {
                    Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(named: "kalakuva")!))
                        .resizable()
                        .scaledToFill()
                }
                ZStack(alignment: .topTrailing) {
                    VStack {
                        HStack {
                            Text(fish.title ?? "No Data")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            Spacer()
                        }.padding(.leading, 10) //:HSTACK
                            .padding(.top, 10)
                        HStack {
                            VStack(alignment: .trailing, spacing: 15) {
                                Text(fish.timestamp ?? Date() , formatter: itemFormatter)
                                    .font(.body)
                                    .fontWeight(.bold)
                                 .foregroundColor(.gray)
                            } //:VSTACK
                            .padding(.leading, 10) //:HSTACK
                            Spacer()
                        } //:HSTACK
               
                            InsetDetailsView(fish: fish)
                 
                        HStack {
                            
                            VStack(alignment: .center, spacing: 25) {
                                HeadingView(headingImage: "note.text", headingText: "Notes", headingTextColor: "Color4")
                                Text(fish.details ?? "No Data")
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                
                                HeadingView(headingImage: "map", headingText: "Location", headingTextColor: "Color4")
                                
                                Map(coordinateRegion: $region,
                                                interactionModes: .all,
                                                showsUserLocation: true,
                                                annotationItems: annotations) {
                                                MapPin(coordinate: $0.coordinate)
                                }
                                    .frame(width: 350, height: 250)
                                    
                            }
                            
                            
                            
                            
                        }
                        
                        
                        
                        
         
                        HStack {
                            VStack(alignment: .trailing, spacing: 25) {
                                Button("Delete", role: .destructive) {
                                    isShowingDialog = true
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                .confirmationDialog("Are you sure to delete the data, this action can't be reversed?", isPresented: $isShowingDialog, titleVisibility: .visible) {
                                    
                                    Button("Confirm", role: .destructive) {
                                        
                                        do {
                                            moc.delete(self.fish)
                                            try moc.save()
                                        } catch {
                                            print("Error deleting data")
                                        }
                                    }
                                    Button("Cancel", role: .cancel) {
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                        
                    } //: VSTACK
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    
                    //.background(CustomShape().fill(Color("Color-List-Outside-1")))
                    .background (
                        LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
                    .clipShape(Corners()
                    )
                } //: ZSTACK
                
                .zIndex(40)
                .offset(y: -40)
                
                //Spacer()
                
            }
            
        } //: ZSTACK
        .edgesIgnoringSafeArea(.all)
        
    }
}


//Shape under the image
struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}

struct Corners : Shape {
    func path(in rect: CGRect) -> Path {
        
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 305))
        return Path(path.cgPath)
    }
}


