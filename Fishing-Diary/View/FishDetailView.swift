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
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // HEADER
                    FishHeaderView(fish: fish)
                        
                    // TITLE
                    VStack(alignment: .leading, spacing: 20) {
                        Text(fish.title ?? "Kuha 50kg")
                            .font(.largeTitle)
                        .fontWeight(.heavy)
                        
                        Text(fish.details ?? "Kala joka otettu saimaanniemeltä, kuvan ottanut Joni ja kalan saanut Joonas")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                    }//:VSTACK
                
                } //:VSTACK
            }//: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
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
