//
//  UserViewModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 15/06/22.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var user = UserModel()
    
    func saveUser() {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(user, forKey: "User")
        }
    }
    
}
