//
//  PlanetColors.swift
//  Wolors
//
//  Created by Francesco Monaco on 15/06/22.
//

import Foundation
import SwiftUI

struct PlanetColors {
    
    let colorOne: LinearGradient = LinearGradient(colors: [.theme.bigPlanetFirst, .theme.bigPlanetSecond], startPoint: .leading, endPoint: .trailing)
    
    let colorTwo: LinearGradient = LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing)
    
    let colorThree: LinearGradient = LinearGradient(colors: [.indigo.opacity(0.7), .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
    
}
