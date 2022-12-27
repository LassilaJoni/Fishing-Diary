//
//  InsetImageView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 20.8.2022.
//

import SwiftUI
import CoreData

struct InsetImageView: View {
    
    @State var image : Data = .init(count: 0)
    
    let fish: Fish
    
    var body: some View {
        Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(named: "kalakuva")!))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .pinchToZoom()
        
            .navigationBarTitleDisplayMode(.inline)
                                      .toolbar {
                                          ToolbarItem(placement: .principal) {
                                              VStack {
                                                  
                                                  Text(fish.title ?? "").font(.headline)
                                                      
                                                  Text(fish.timestamp!, formatter: itemFormatter).font(.subheadline)
                                              } //: VSTACK
                                              .foregroundColor(.accentColor)
                                          }
                                      } //: TOOLBAR
                                      .background(.black)
    } //: BODY
        
}

struct InsetImageView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFish
        InsetImageView(fish: fish)
    }
}
