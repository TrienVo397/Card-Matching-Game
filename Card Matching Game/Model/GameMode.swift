//
//  GameMode.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation
enum GameMode: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"

    var timeLimit: Int {
        switch self {
        case .easy: return 60
        case .medium: return 40
        case .hard: return 20
        }
    }

    var scoreMultiplier: Int {
        switch self {
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        }
    }
}
