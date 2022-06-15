//
//  WolorsApp.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI

@main
struct WolorsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserViewModel())
                .environmentObject(LevelViewModel())
        }
        
    }
}
