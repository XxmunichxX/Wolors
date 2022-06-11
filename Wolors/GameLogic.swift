//
//  GameLogic.swift
//  Wolors
//
//  Created by Francesco Monaco on 10/06/22.
//

import Foundation
import SwiftUI

class GameLogic: ObservableObject {
    
    static let shared: GameLogic = GameLogic()
    
    @EnvironmentObject var user: User
    
    @Published var isGameOver: Bool = false
    
    func setUpGame() {
        
        //LIFES = 3
        // NAME = ""
        
        self.isGameOver = false
    }
    
    @Published var currentScore: Int = 0
    
    func score(points: Int) {
        self.currentScore = self.currentScore + points
    }
    
    
    func restartGame() {
        // if lifes == 0
        
        self.setUpGame()
    }
    
    
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
}

