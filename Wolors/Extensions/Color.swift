//
//  Color.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    let background = Color("Background")
    let labels = Color("Labels")
    let hud = Color("Hud")
    let bigPlanetFirst = Color("BigPlanetFirstColor")
    let bigPlanetSecond = Color("BigPlanetSecondColor")
    let lightShadow = Color("LightShadow")
    let darkShadow = Color("DarkShadow")
    
}
