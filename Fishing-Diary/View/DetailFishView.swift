//
//  DetailFishView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 23.12.2022.
//

import SwiftUI
import CoreData
import MapKit

struct DetailFishView: View {
    
    @Environment(\.managedObjectContext) private var moc
    @State var image : Data = .init(count: 0)
    @State private var isShowingDialog = false
    
    let fish: Fish
    @State var detailImage : Data = .init(count: 0)
    
    
    var body: some View {
           ScrollView {
               NavigationLink(destination: InsetImageView(fish: fish)) {
                   Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(named: "kalakuva")!))
                       .resizable()
                       .scaledToFill()
               }
               VStack(spacing: 15) {
                   HStack {
                       Text(fish.title ?? "No Data")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(Color.white)
                       
                       Spacer()
                   }
                   .padding(.top, 15)
                   HStack {
                       VStack(alignment: .trailing) {
                           Text(fish.timestamp ?? Date(), formatter: itemFormatter)
                               .font(.body)
                               .fontWeight(.bold)
                               .foregroundColor(.gray)
                       }
                       Spacer()
                   }
                   InsetDetailsView(fish: fish)
                   HeadingView(headingImage: "note.text", headingText: "Notes")
                   Text(fish.details ?? "No Data")
                       .font(.title3)
                       .foregroundColor(Color.white)
                   
                   
                   Button("Delete", role: .destructive) {
                       isShowingDialog = true
                   }
                   .buttonStyle(.borderedProminent)
                   .controlSize(.large)
                   .confirmationDialog("Are you sure to delete the data, this action can't be reversed?", isPresented: $isShowingDialog, titleVisibility: .visible) {
                       
                       Button("Confirm", role: .destructive) {
                           moc.delete(self.fish)
                           try! moc.save()
                       }
                       Button("Cancel", role: .cancel) {
                           
                       }
                   }
               }
               .padding(.bottom, 40)
               .padding(.horizontal, 20)
                    .background (
                        LinearGradient(gradient: .init(colors: [Color("Color-List-Outside-1"),Color("Color-List-Outside-2"),Color("Color-List-Outside-3"),Color("Color-List-Outside-4")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all))
                    .clipShape(Corners()
                    )
                } //: VSTACK
                .zIndex(40)
                .offset(y: -40)
                
                Spacer()
                
            }
            
        } //: ZSTACK
        

struct DetailFishView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFishes
        DetailFishView(fish: fish)
    }
}

extension NSManagedObjectContext {
    var firstFishes: Fish {
        let fetchRequest = Fish.fetchRequest()
        fetchRequest.fetchLimit = 1
        let result = try! fetch(fetchRequest)
        return result.first!
    }
}
