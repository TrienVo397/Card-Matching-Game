//
//  UserViewModel.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User
    private var dataManager: UserDataManager

    init() {
        self.dataManager = UserDataManager()
        if let loadedUser = dataManager.loadUser() {
            self.user = loadedUser
        } else {
            // Default user or prompt the user to enter a username
            self.user = User(username: "Guest")
        }
    }

    func save() {
        dataManager.saveUser(user)
    }

    // Functions to update user statistics can be added here
    func gamePlayed(didWin: Bool) {
        user.gamesPlayed += 1
        if didWin {
            user.gamesWon += 1
        }
        save()
    }

    func updateHighScore(_ score: Int) {
        if score > user.highScore {
            user.highScore = score
            save()
        }
    }
    func gameEnded(didWin: Bool, gameMode: GameMode, remainingTime: Int) {
            if didWin {
                let score = remainingTime * gameMode.scoreMultiplier
                updateHighScore(score)
            }
            gamePlayed(didWin: didWin)
        }
    }

