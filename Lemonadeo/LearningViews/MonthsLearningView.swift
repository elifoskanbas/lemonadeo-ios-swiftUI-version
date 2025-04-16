//
//  MonthsLearningView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct MonthsLearningView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    @State var months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    
     let columns = [
         GridItem(.adaptive(minimum: 100))
     ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(months, id: \.self) { item in
                            Button(action: {
                                playSound(item)
                            }) {
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                            }
                        }
                    }
                    .padding()
                    
                    
                }
                
                
                
                
            }
            .navigationTitle("Months")
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
    MonthsLearningView()
}
