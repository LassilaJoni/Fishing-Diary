//
//  MapMainView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 29.12.2022.
//

import SwiftUI
import MapKit
import CoreData
import CoreLocationUI
import StoreKit


struct MapMainView: View {
 
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
           MapView()
                .ignoresSafeArea(.all)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: dismiss, label: {
                            Circle()
                                .fill(Color(.black))
                                .frame(width: 40, height: 30) // You can make this whatever size, but keep UX in mind.
                                .overlay(
                                    Image(systemName: "xmark")
                                        .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                        .foregroundColor(.white)
                                )
                        })
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityLabel(Text("Close"))
                    }
                }

        }
   
    }
    
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
struct MapMainView_Previews: PreviewProvider {
    
    @State static var mapView: MKMapView = MKMapView()
    
    static var previews: some View {
        MapMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

