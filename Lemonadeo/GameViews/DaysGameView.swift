//
//  DaysGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct DaysGameView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State var days = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
    let answer = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State var isGameOver = false
    @State var index = 0
    @State private var selectedItem: String? = nil
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(days, id: \.self) { item in
                            Button(action: {
                                if (index < days.count - 1) && (answer[index] == item) {
                                    selectedItem = item
                                    index += 1
                                    playSound()
                                } else if index == days.count - 1 && answer[index] == item {
                                    selectedItem = item
                                    playSound()
                                    isGameOver = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        index = 0
                                        days.shuffle()
                                        selectedItem = nil
                                            }
                                    
                                }
                            }) {
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedItem == item ? Color.green : Color.clear, lineWidth: 4)
                                    )
                            }
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        index = 0
                        selectedItem = nil
                        days.shuffle()
                    }) {
                        Text("Shuffle")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Days Game")
            .background(
                Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255)
                    .ignoresSafeArea()
            )
            .alert("Well Done!", isPresented: $isGameOver) {
                Button("Play Again") {
                    index = 0
                    days.shuffle()
                    selectedItem = nil
                    isGameOver = false
                }
            } message: {
                Text("You've sorted all the days!")
            }
        }
    }
    
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "correct", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    DaysGameView()
}
