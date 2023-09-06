//
//  UserDataManager.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation

class UserDataManager {
    private var userFileURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("users.json")
    }

    func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            try data.write(to: userFileURL)
        } catch {
            print("Error saving user: \(error)")
        }
    }

    func loadUser() -> User? {
        do {
            let data = try Data(contentsOf: userFileURL)
            let decodedUser = try JSONDecoder().decode(User.self, from: data)
            return decodedUser
        } catch {
            print("Error loading user: \(error)")
            return nil
        }
    }
}
