//
//  HeadingView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 22.12.2022.
//

import SwiftUI

struct HeadingView: View {
    
    var headingImage: String
    var headingText: String
    var headingTextColor: String
        
        var body: some View {
            HStack {
                Image(systemName: headingImage)
                    .foregroundColor(Color("Color-1"))
                    .imageScale(.large)
                Text(headingText)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("\(headingTextColor)"))
            }
            .padding(.vertical)
        }
    }

    struct HeadingView_Previews: PreviewProvider {
        static var previews: some View {
            HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Kuvat", headingTextColor: "Color-1")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
