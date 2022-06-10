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
    
    @Published var sessionDuration: TimeInterval = 0
    @Published var isGameOver: Bool = false
    
    func setUpGame() {
        
        self.currentScore = 0
        self.sessionDuration = 0
        
        self.isGameOver = false
    }
    
    @Published var currentScore: Int = 0
    
    func score(points: Int) {
        self.currentScore = self.currentScore + points
    }
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
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

