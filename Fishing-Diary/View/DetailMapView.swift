//
//  DetailMapView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI
import MapKit

struct DetailMapView: View {
    
    @StateObject var manager = LocationManager()
    @State var tracking:MapUserTrackingMode = .none
    
    var body: some View {
        Map(
           coordinateRegion: $manager.region,
           interactionModes: MapInteractionModes.all,
           showsUserLocation: true,
           userTrackingMode: $tracking
        )
    }
}

struct DetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMapView()
    }
}
