import SwiftUI

struct MenuView: View {
    @State private var selectedGameMode: GameMode = .easy
    @State private var isShowingGameView: Bool = false
    @State private var isShowingNamePrompt: Bool = false
    @State private var playerName: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Memory Card Matching Game")
                    .font(.largeTitle)
                    .padding()
                TextField("Enter your name", text: $playerName)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .padding(.horizontal)

                Button(action: {
                                    isShowingGameView = true
                                }) {
                                    Text("Start Game")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .disabled(playerName.isEmpty)
                                .opacity(playerName.isEmpty ? 0.5 : 1.0)
                                .sheet(isPresented: $isShowingGameView) {
                                    EmojiMemoryGameView(viewModel: MemoryGameViewModel(gameMode: selectedGameMode, playerName: playerName), playerName: $playerName)
                                }
                NavigationLink(destination: LeaderBoardView()) {
                                    Text("Leaderboard")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }

                NavigationLink(destination: Text("How To Play View")) {
                    Text("How To Play")
                        .font(.headline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: GameSettingsView(selectedGameMode: $selectedGameMode)) {
                    Text("Game Settings")
                        .font(.headline)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
    }
}

struct GameSettingsView: View {
    @Binding var selectedGameMode: GameMode

    var body: some View {
        VStack {
            Text("Select Game Difficulty")
                .font(.headline)
                .padding()

            Picker("Difficulty", selection: $selectedGameMode) {
                Text("Easy").tag(GameMode.easy)
                Text("Medium").tag(GameMode.medium)
                Text("Hard").tag(GameMode.hard)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()
        }
    }
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
