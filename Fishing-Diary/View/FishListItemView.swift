//
//  FishListItemView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 8.8.2022.
//

import SwiftUI

struct FishListItemView: View {
        let fish: Fish
        @State var image : Data = .init(count: 0)
        
        var body: some View {
            
            
           
           
            HStack {
                VStack {
                Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(named: "kalakuva"))!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .cornerRadius(10)
                } //: VSTACK
                VStack {
                        Text(fish.title ?? "Something went wrong fetching the title")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .lineLimit(3)
                       
                        Text(fish.specie ?? "Error")
                        .foregroundColor(Color.white)
                } //: VSTACK
                    //Centers the text
            
                
            } //: HSTACK
            .padding(.vertical)
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            .padding(.top, 5)
               

    }
}

struct FishListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFish
        FishListItemView(fish: fish)
            .previewLayout(.sizeThatFits)
    }
}
