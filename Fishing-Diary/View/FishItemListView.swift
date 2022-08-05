//
//  FishItemListView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI

struct FishItemListView: View {
    let fish: Fish
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        HStack {
                   
            Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(systemName: "photo"))!)
                   
                       .resizable()
                       .scaledToFill()
                       .frame(width: 120, height: 120)
                       .clipShape(RoundedRectangle(cornerRadius: 14))
                   
                       
                   
                   VStack(alignment: .leading, spacing: 5) {
                       Text(fish.title ?? "")
                           .font(.title2)
                           .fontWeight(.heavy)
                       .foregroundColor(.accentColor)
                   
                   
                       Text(fish.timestamp!, formatter: itemFormatter)
                       .font(.footnote)
                       .lineLimit(2)
                       .padding(.trailing, 8)
                       
                   } //: VSTACK
                       
                       
                   
               } //: HSTACK
    }
}

struct FishItemListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFish
        FishItemListView(fish: fish)
            .previewLayout(.sizeThatFits)
    }
}
