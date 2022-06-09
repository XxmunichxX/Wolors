//
//  LevelModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import Foundation

struct Level:Identifiable {
    var id = UUID().uuidString
    var image: String = ""
    var isSolved: Bool = false
}
