//
//  FishHeaderView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI
import CoreData

struct FishHeaderView: View {
    
    let fish: Fish
    
    @State private var isAnimatingImage: Bool = false
    
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        ZStack {
            Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(systemName: "photo")!))
            .resizable()
            .scaledToFit()
            .shadow(color: Color("LightShadow"), radius: 8, x: 8, y: 8)
            .shadow(color: Color("DarkShadow"), radius: 8, x: 8, y: 8)
            .padding(.vertical, 20)
            .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
        } //: ZSTACK
        .frame(height: 440)
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimatingImage = true
            }
        }
    }
}

struct FishHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFish
        FishHeaderView(fish: fish)
            .previewLayout(.sizeThatFits)
    }
}
