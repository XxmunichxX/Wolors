//
//  LevelViewModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import Foundation

class LevelViewModel: ObservableObject {
        
    @Published var levels: [Level] = [
        Level(image: "Baloon", isSolved: false),
        Level(image: "Mother", isSolved: false),
        Level(image: "Ocean", isSolved: false),
        Level(image: "Tree", isSolved: false)
    ]
    
    @Published var solvedLevels = [Level]()
    
    @Published var selectedLevel = 0
    
    func addLevel(level: Level) {
        solvedLevels.append(level)
    }

}
