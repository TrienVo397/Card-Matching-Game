import SwiftUI

struct MenuView: View {
    @State private var selectedGameMode: GameMode = .easy
    @State private var isShowingGameView: Bool = false
    @State private var isShowingNamePrompt: Bool = false
    @State private var playerName: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("greenBg")
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Image("cardmemory")
                        .resizable()
                        .padding(.horizontal, 20.0)
                        .scaledToFit()
                    Image("matchinggame")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal,20)
                    
                    Spacer()
                    TextField("Enter your name to play", text: $playerName)
                        .multilineTextAlignment(.center)
                                        .padding()
                                        .background(Color.white.opacity(0.4))
                                        .cornerRadius(8)
                                        .padding(.horizontal)
                                        .frame(width: 300, height: 100)
                    

                    Button(action: {
                                        isShowingGameView = true
                                    }) {
                                        Text("START GAME")
                                            .font(.headline)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                    
                    
                                    .disabled(playerName.isEmpty)
                                    .opacity(playerName.isEmpty ? 0.3 : 1.0)
                                    .sheet(isPresented: $isShowingGameView) {
                                        EmojiMemoryGameView(viewModel: MemoryGameViewModel(gameMode: selectedGameMode, playerName: playerName), playerName: $playerName)
                                    }
                    NavigationLink(destination: LeaderBoardView()) {
                                        Text("LEADERBOARD")
                                            .font(.headline)
                                            .padding()
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }

                    NavigationLink(destination: Text("How To Play View")) {
                        Text("HOW TO PLAY")
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }

                    NavigationLink(destination: GameSettingsView(selectedGameMode: $selectedGameMode)) {
                        Text("SETTINGS")
                            .font(.headline)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct GameSettingsView: View {
    @Binding var selectedGameMode: GameMode

    var body: some View {
        ZStack {
            Image("greenBg")
                .resizable()
                .ignoresSafeArea()
            
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
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
