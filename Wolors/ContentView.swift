//
//  ContentView.swift
//  Wolors
//
//  Created by Francesco Monaco on 09/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentGameState: GameState = .mainScreen
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
