//
//  LevelViewModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import Foundation

class LevelViewModel: ObservableObject {
        
    @Published var levels: [Level] = [
        Level(image: "Baloon", answers: ["Baloons", "Love", "Sky", "Flying"], isSolved: false),
        Level(image: "Mother", answers: ["Mother", "Baby", "Love"], isSolved: false),
        Level(image: "Ocean", answers: ["Ocean", "Sea", "Wale", "Turtle"], isSolved: false),
        Level(image: "Tree", answers: ["Tree", "Sun", "Savana", "Hot"], isSolved: false)
            ]
    
    @Published var solvedLevels = [Level]()
    
    @Published var selectedLevel = 0
    
    func addLevel(level: Level) {
        solvedLevels.append(level)
    }

}
