//
//  LevelViewModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import Foundation

class LevelViewModel: ObservableObject {
    
    @Published var level = Level() {
        didSet {
            saveReachedLevel()
        }
    }
    
    @Published var levels: [Level] = [
        Level(image: "Baloon", answers: ["Balloons", "Love", "Sky", "Flying"],hints: ["They are not racoons, just...", "How deep is your...", "The moon is full, the .. is full of stars", "As Peter Pan we all dream about..."],isSolved: false),
        Level(image: "Mother", answers: ["Mother", "Baby", "Love","Child"],hints:["Mine's not like the other. I'm talking about my...","People saying they are never ready, when it suddenly comes a...","...is always the answer","You, sweet ... of mine"] ,isSolved: false),
        Level(image: "Ocean", answers: ["Ocean", "Sea", "Wale", "Turtle"],hints: ["1","2","3","4"], isSolved: false),
        Level(image: "Tree", answers: ["Tree", "Sun", "Savana", "Hot"],hints:["1","2","3","4"], isSolved: false)
            ]
    
    @Published var guessedWords:[String] = [String]()
    
    @Published var solvedLevels = [Level]()
    
    func saveReachedLevel() {
        if let encodedLevel = try? JSONEncoder().encode(level.selectedLevel) {
            UserDefaults.standard.set(encodedLevel, forKey: "SelectedLevel")
        }
    }
    
    func loadLevel() {
        guard
            let data = UserDefaults.standard.data(forKey: "SelectedLevel"),
            let savedLevel = try? JSONDecoder().decode(Level.self, from: data)
        else { return }
        
        self.level = savedLevel
        
    }

}
