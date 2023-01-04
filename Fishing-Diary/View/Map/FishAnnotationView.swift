//
//  FishAnnotationView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 4.1.2023.
//

import SwiftUI

struct FishAnnotationView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .foregroundColor(.blue)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .frame(width: .infinity)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -4)
        }
    }
}

struct FishAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            FishAnnotationView(title: "Testi")
        }
    }
}
