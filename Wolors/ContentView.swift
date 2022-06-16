//
//  ContentView.swift
//  Wolors
//
//  Created by Francesco Monaco on 09/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var user: UserModel = UserModel()
    
    var body: some View {
        
        switch user.logged {
        case false:
            OnBoardView()
        case true:
            MainView()
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
