//
//  MonthsGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct MonthsGameView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State var months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    let answer = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    @State var index = 0
    @State private var selectedItem: String? = nil
    @State private var isGameOver = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(months, id: \.self) { item in
                            Button(action: {
                                if index < months.count - 1 && answer[index] == item {
                                    selectedItem = item
                                    index += 1
                                    playSound()
                                } else if index == months.count - 1 && answer[index] == item {
                                    selectedItem = item
                                    playSound()
                                    isGameOver = true
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
                        months.shuffle()
                        selectedItem = nil
                        index = 0
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
            .navigationTitle("Months Game")
            .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255).ignoresSafeArea())
            .alert("Well Done!", isPresented: $isGameOver) {
                Button("Play Again") {
                    index = 0
                    months.shuffle()
                    selectedItem = nil
                    isGameOver = false
                }
            } message: {
                Text("You've sorted all the months!")
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

struct MonthsGameView_Previews: PreviewProvider {
    static var previews: some View {
        MonthsGameView()
    }
}
