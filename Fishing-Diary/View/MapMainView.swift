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


struct MapMainView: View {
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        @StateObject var viewRouter: ViewRouter
       }
    
    

    var body: some View {
        VStack {
                    MapView()
                .ignoresSafeArea(.all)
           
                }
            
    }
}

struct MapMainView_Previews: PreviewProvider {
    static var previews: some View {
        MapMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
