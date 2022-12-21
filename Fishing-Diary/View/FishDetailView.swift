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
    
    @Environment(\.managedObjectContext) private var moc
    @State var image : Data = .init(count: 0)
    @State private var isShowingDialog = false
    
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
                                .foregroundColor(Color("Color5"))
                            
                            Spacer()
                        }.padding(.top, 15) //:HSTACK
                        HStack {
                            VStack(alignment: .trailing, spacing: 15) {
                                Text(fish.timestamp ?? Date() , formatter: itemFormatter)
                                    .font(.body)
                                    .fontWeight(.bold)
                                 .foregroundColor(.gray)
                            } //:VSTACK
                            Spacer()
                        } //:HSTACK
                        //If Want space between title and timestamp
                        .padding(.top, 15)
                        HStack {
                            InsetDetailsView(fish: fish)
                            /*Text("Specie: " + (fish.specie ??  "Error fetching details"))
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            Spacer()*/
                        } //.padding(.top, 15) //:HSTACK
                        HStack {
                            
                            VStack(alignment: .trailing, spacing: 25) {
                                Text(fish.details ?? "Error fetching description")
                                    .font(.body)
                            }
                            
                            
                        }
                        
                        
                        HStack {
                            VStack(alignment: .trailing, spacing: 25) {
                                Button("Delete", role: .destructive) {
                                    isShowingDialog = true
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                .confirmationDialog("Are you sure to delete the data?", isPresented: $isShowingDialog, titleVisibility: .visible) {
                                    
                                    Button("Confirm", role: .destructive) {
                                        moc.delete(self.fish)
                                        try! moc.save()
                                    }
                                    Button("Cancel", role: .cancel) {
                                        
                                    }
                                    
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
        
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
