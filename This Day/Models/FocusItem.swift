//
//  FocusItem.swift
//  This Day
//
//  Created by Heather Mason on 7/25/25.
//

import Foundation

struct FocusItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
