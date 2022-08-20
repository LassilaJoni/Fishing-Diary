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
        ScrollView {
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


struct Detail: View {
    
    @State var image : Data = .init(count: 0)
    let fish: Fish
    
    var body: some View {
        ZStack {
            Color("Color-1").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                NavigationLink(destination: InsetImageView(fish: fish)) {
                Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(named: "kalakuva")!))
                    .resizable()
                    //.frame(height: UIScreen.main.bounds.height / 3)
                    .scaledToFill()
                }
                ZStack(alignment: .topTrailing) {
                VStack {
                    HStack {
                        Text(fish.title ?? "Error in getting the title")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }.padding(.top, 15) //:HSTACK
                    HStack {
                        VStack(alignment: .trailing, spacing: 15) {
                            Text(fish.timestamp!, formatter: itemFormatter)
                                .foregroundColor(.gray)
                        } //:VSTACK
                        Spacer()
                    } //:HSTACK
                    //If Want space between title and timestamp
                    .padding()
                    
                    HStack {
                        
                        VStack(alignment: .trailing, spacing: 25) {
                            Text(fish.details ?? "Error fetching description")
                        }
                        
                    }
                    
                    HStack {
                        VStack(alignment: .trailing, spacing: 25) {
                            DetailMapView()
                                .frame(height: UIScreen.main.bounds.height / 3)
                                
                        } //: VSTACK
                        
                    } //:HSTACK
                    
                    HStack {
                        VStack(alignment: .trailing, spacing: 25) {
                            Button(action: {
                                print("Poistettu")
                            }) {
                                
                                    Text("DELETE")
                                    .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 100)
                                        .background(
                                            LinearGradient(gradient: .init(colors: [Color(.red)]), startPoint: .leading, endPoint: .trailing)
                                        )
                                    
                                }
                        }
                    }
                    
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 20)
                .background(CustomShape().fill(Color.white))
                .clipShape(Corners())
                } //: VSTACK
                .zIndex(40)
                .offset(y: -40)
                
                Spacer()
                
            }
            
        } //: ZSTACK
        .edgesIgnoringSafeArea(.all)
    }
    
}

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
        
            
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
            return Path(path.cgPath)
    }
}
