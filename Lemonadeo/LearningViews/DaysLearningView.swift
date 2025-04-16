//
//  DaysLearningView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation


struct DaysLearningView: View {
    @State private var audioPlayer: AVAudioPlayer?

    @State var days = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(days, id: \.self) { item in
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
            .navigationTitle("Days")
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
    DaysLearningView()
}
