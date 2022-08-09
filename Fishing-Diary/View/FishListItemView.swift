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
            
            
           
           
            VStack {
                
                Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(systemName: "photo"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    VStack(alignment: .leading) {
                       /* Text("Testi")
                            .font(.headline)
                            .foregroundColor(.secondary)*/
                        Text(fish.title ?? "Something went wrong fetching the title")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text(fish.timestamp!, formatter: itemFormatter)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    
                    //Centers the text
                    //Spacer()
                    
                    
                } //: HSTACK
                
                
                    
                
                
            } //: VSTACK
            .padding(.vertical)
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            //.background(Color.white)
            //.cornerRadius(10)
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
