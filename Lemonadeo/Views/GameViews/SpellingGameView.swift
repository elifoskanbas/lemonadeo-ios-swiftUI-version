//
//  SpellingGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct SpellingGameView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var spelling = ["autmn", "wednesday", "orange", "saturday", "january", "green", "tongue", "finger"]
    @State private var answer = ""
    @State private var index = 0
    @State private var isGameOver = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0)
                    .ignoresSafeArea()
                
                VStack {
                    if index < spelling.count {
                        Button(action: {
                            playSound(spelling[index])
                        }) {
                            Image(spelling[index])
                                .resizable()
                                .frame(maxWidth: 250, maxHeight: 250)
                        }
                        .padding()

                        TextField("Enter your answer", text: $answer)
                            .textInputAutocapitalization(.never)
                            .frame(width: .infinity,height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke( Color.gray, lineWidth: 2)
                            )
                            .padding()

                        Button(action: {
                            playSound(answer == spelling[index] ? "correct" : "incorrect")

                            if index < spelling.count - 1 {
                                index += 1
                                answer = ""
                            } else {
                                isGameOver = true
                            }
                        }) {
                            Text("Submit")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .padding()
                    }
                }
                .navigationTitle("Spelling Game")
                .alert("Game Over", isPresented: $isGameOver) {
                    Button("Play Again") {
                        index = 0
                        answer = ""
                    }
                } message: {
                    Text("You've finished all the words!")
                }
            }
        }
    }

    func playSound(_ name: String) {
        if let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    SpellingGameView()
}
