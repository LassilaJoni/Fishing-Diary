//
//  MapPin.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 3.1.2023.
//

import SwiftUI
import MapKit

struct MapPins: View {
    let coordinate: CLLocationCoordinate2D
    let fishAnnotations: FishAnnotations

    @State private var showLocationPreview = false

    var body: some View {
        VStack {
            Button(action: {
                self.showLocationPreview.toggle()
            }) {
                Image(systemName: "circle.fill")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
            .sheet(isPresented: $showLocationPreview) {
                LocationPreviewView(fish: fishAnnotations.fish)
            }
        }
    }
}

struct FishAnnotations: Identifiable {
    let id = UUID()
    let fish: Fish
    let coordinate: CLLocationCoordinate2D
}
