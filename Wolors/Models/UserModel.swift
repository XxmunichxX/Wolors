//
//  UserModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 08/06/22.
//

import Foundation

class User: ObservableObject {
    @Published var name: String = ""
    @Published var lifes: Int = 3
    @Published var coins: Int = 0
    @Published var hints: Int = 3
}
