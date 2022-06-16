//
//  UserViewModel.swift
//  Wolors
//
//  Created by Francesco Monaco on 15/06/22.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var user = UserModel() {
        didSet {
            saveUser()
        }
    }
    
    func saveUser() {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedData, forKey: "User")
        }
    }
    
    func loadUser() {
        guard
            let data = UserDefaults.standard.data(forKey: "User"),
            let savedItems = try? JSONDecoder().decode(UserModel.self, from: data)
        else { return }
        
        self.user = savedItems
    }
    
}
