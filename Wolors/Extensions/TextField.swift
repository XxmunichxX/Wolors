//
//  TextField.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import Foundation
import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .padding(10)
    }
}
