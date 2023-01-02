//
//  InsetDetailsView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 21.12.2022.
//

import SwiftUI



struct InsetDetailsView: View {
    
    let fish: Fish
    
    var body: some View {
        VStack {
        
        HStack {
            Text("Fish weight:")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
            Text(fish.weight ?? "Error getting fish weight")
                       .foregroundColor(.white)
                       .padding()
                   Spacer()
                   Image(systemName: "scalemass.fill")
                       .foregroundColor(Color("Color-1"))
                       .padding()
                       .background(Color.white)
                       .cornerRadius(20)
                       .padding([.trailing], 5)
               } //: VSTACK
               .frame(maxWidth: .infinity, maxHeight: 60)
               .background(Color("Color-1"))
               .cornerRadius(10)
        
        } //: VSTACK
    } //: BODY
}

struct InsetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFish
        InsetDetailsView(fish: fish)
    }
}
