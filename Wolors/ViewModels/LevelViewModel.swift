//
//  LevelViewModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import Foundation

class LevelViewModel: ObservableObject {
    
    let level = Level()
    
    @Published var levels: [Level] = [
        Level(image: "Baloon", answers: ["Baloons", "Love", "Sky", "Flying"],hints: ["They are not racoons, just...", "How deep is your...", "The moon is full, the .. full of stars", "Overflying's never over"],isSolved: false),
        Level(image: "Mother", answers: ["Mother", "Baby", "Love","Child"],hints:["1","2","3","4"] ,isSolved: false),
        Level(image: "Ocean", answers: ["Ocean", "Sea", "Wale", "Turtle"],hints: ["1","2","3","4"], isSolved: false),
        Level(image: "Tree", answers: ["Tree", "Sun", "Savana", "Hot"],hints:["1","2","3","4"], isSolved: false)
            ]
    
    @Published var guessedWords:[String] = [String]()
    
    @Published var solvedLevels = [Level]()
    
    @Published var selectedLevel = 0
    
    func saveReachedLevel() {
        
    }

}
