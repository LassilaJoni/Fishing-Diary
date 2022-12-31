//
//  ViewRouter.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 30.12.2022.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
    
}


enum Page {
    case home
    case map
}
