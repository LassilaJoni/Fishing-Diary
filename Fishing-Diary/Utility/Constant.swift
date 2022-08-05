//
//  Constant.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import SwiftUI

// MARK: - FORMATTER

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
