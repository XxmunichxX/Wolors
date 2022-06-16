//
//  ContentView.swift
//  Wolors
//
//  Created by Francesco Monaco on 09/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        
        switch user.user.logged {
        case false:
            OnBoardView()
        case true:
            MainView(opacity: .constant(0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LevelViewModel())
            .environmentObject(UserViewModel())
    }
}
