//
//  MemoryGameViewModel.swift
//  Card Matching Game
//
//  Created by Người dùng Khách on 06/09/2023.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame<String>
    @Published var remainingTime: Int
    private var gameMode: GameMode
    private var timer: Timer?
    @Published var playerName: String = ""


    init(gameMode: GameMode) {
        self.gameMode = gameMode
        model = MemoryGameViewModel.createMemoryGame(gameMode: gameMode)
        self.remainingTime = gameMode.timeLimit
        startTimer()
    }

    private static func createMemoryGame(gameMode: GameMode) -> MemoryGame<String> {
        let emojis = ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
        if model.cards.allSatisfy({ $0.isMatched }) {
            // All cards are matched, stop the timer
            timer?.invalidate()
        }
    }

    func resetGame() {
        model = MemoryGameViewModel.createMemoryGame(gameMode: gameMode)
        self.remainingTime = gameMode.timeLimit
        startTimer()
    }
    func savePlayerScore() {
            let playerScore = PlayerScore(name: playerName, score: score)
            UserDefaults().savePlayerScore(playerScore)
        }

    private func startTimer() {
        timer?.invalidate() // invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if self?.remainingTime ?? 0 > 0 {
                self?.remainingTime -= 1
            } else {
                self?.timer?.invalidate()
                // Handle game over due to time running out in the ViewModel
            }
        }
    }
    
    var score: Int {
        gameMode.timeLimit - remainingTime
    }
}
