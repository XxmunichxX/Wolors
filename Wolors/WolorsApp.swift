//
//  WolorsApp.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI

@main
struct WolorsApp: App {
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserViewModel())
                .environmentObject(LevelViewModel())
        }
    }
}
