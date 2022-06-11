//
//  ContentView.swift
//  Wolors
//
//  Created by Francesco Monaco on 09/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentGameState: GameState = .mainScreen
    
    @StateObject var gameLogic: GameLogic = GameLogic()
    
    var body: some View {
        
        switch currentGameState {
        case .mainScreen:
            MainView(currentGameState: $currentGameState)
        case .playing:
            MainView(currentGameState: $currentGameState)
        case .gameOver:
            MainView(currentGameState: $currentGameState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LevelViewModel())
            .environmentObject(User())
    }
}
