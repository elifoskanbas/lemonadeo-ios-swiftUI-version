//
//  DirectionsGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct DirectionsGameView: View {
    let directions = ["above", "across", "among", "around", "behind", "beside", "between", "down", "far", "front", "inside", "near", "on", "opposite", "outside", "through", "under", "up"]
    @State private var audioPlayer: AVAudioPlayer?
    @State private var index = 0
    @State private var isGameOver = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255)
                    .ignoresSafeArea()
                
                VStack {
                    if index < directions.count {
                        let currentIndex = index
                        
                        Image(directions[currentIndex])
                            .resizable()
                            .frame(maxWidth: 250, maxHeight: 250)
                            .padding()
                        
                        HStack {
                          
                            Button {
                                index += 1
                                playSound("correct")
                                if index >= directions.count {
                                    isGameOver = true
                                }
                            } label: {
                                Text(directions[currentIndex])
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            
                            
                            Button {
                                index += 1
                                playSound("incorrect")
                                if index >= directions.count {
                                    isGameOver = true
                                }
                            } label: {
                                if let wrongOption = randomStringExcept(from: directions, except: currentIndex) {
                                    Text(wrongOption)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                } else {
                                    Text("N/A")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Spelling Game")
                .alert("Well Done!", isPresented: $isGameOver) {
                    Button("Play Again") {
                        index = 0
                    }
                } message: {
                    Text("Play Again")
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

    func randomStringExcept(from array: [String], except index: Int) -> String? {
        guard array.indices.contains(index), array.count > 1 else {
            return nil
        }

        var indices = Array(array.indices)
        indices.removeAll { $0 == index }

        if let randomIndex = indices.randomElement() {
            return array[randomIndex]
        }

        return nil
    }
}

#Preview {
    DirectionsGameView()
}
