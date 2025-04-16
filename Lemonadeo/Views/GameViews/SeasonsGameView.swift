//
//  SeasonsGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct SeasonsGameView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State var seasons = ["winter","spring","summer","autmn"]
    @State var answer = 0
    @State private var selectedItem: String? = nil
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(seasons, id: \.self) { item in
                            Button(action: {
                                if seasons[answer] == item {
                                    answer = Int.random(in: 0...3)
                                    playSound("correct")

                                }
                            }) {
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedItem == item ? Color.green : Color.clear, lineWidth: 4)
                                    )
                            }
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        playSound(seasons[answer])
                    }) {
                        Text("Play")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                
                
                
                
            }
            .navigationTitle("Seasons Game")
            .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0).ignoresSafeArea())
            
            
        }
    }
    
    func playSound(_ x : String) {
        if let soundURL = Bundle.main.url(forResource: x , withExtension: "mp3") {
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
    SeasonsGameView()
}
