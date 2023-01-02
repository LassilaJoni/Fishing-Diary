//
//  SettingsCell.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 2.1.2023.
//

import SwiftUI

struct SettingsCell: View {
    
    var title: String
       var imgName: String
       var color: Color
    
    var body: some View {
        HStack {
                    Image(systemName: imgName)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(title)
                        .font(.headline)
                        .padding(.leading, 10)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                }//: HSTACK
            .preferredColorScheme(.dark)
               
            }
        }

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(title: "Email", imgName: "exclamationmark.triangle.fill", color: .white)
    }
}
