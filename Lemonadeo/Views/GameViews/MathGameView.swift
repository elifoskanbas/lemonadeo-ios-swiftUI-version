//
//  MathGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI
import AVFoundation

struct MathGameView: View {
    @State private var audioPlayer: AVAudioPlayer?
    var difficulty = ["easy","medium","hard"]
    @State var difficultySelected : String = "easy"
    @State var num1 : Int = 0
    @State var num2 : Int = 0
    @State var result : String = ""
    @State var isGameOver = false
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0)
                    .ignoresSafeArea()
                ScrollView {
                    HStack(spacing: -30){
                        Button(action: {
                            difficultySelected = difficulty[0]
                            num1 = Int.random(in: 0...10)
                            num2 = Int.random(in: 0...10)
                        }) {
                            Text("easy")
                                .padding()
                                .frame(width:100,height: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        Button(action: {
                            difficultySelected = difficulty[1]
                            num1 = Int.random(in: 0...30)
                            num2 = Int.random(in: 0...30)
                        }) {
                            Text("medium")
                                .padding()
                                .frame(width:100,height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            difficultySelected = difficulty[2]
                            num1 = Int.random(in: 0...90)
                            num2 = Int.random(in: 0...90)
                        }) {
                            Text("hard")
                                .padding()
                                .frame(width:100,height: 40)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        
                    }
                    
                    
                    Spacer(minLength: 200)
                    
                    VStack(spacing: 0.0){
                        HStack{
                            Text("\(num1)")
                                .padding()
                                .frame(width:70,height: 70)
                                .background(Color.gray)
                                .font(.title)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            Text("x")
                                .padding()
                                .frame(width:70,height: 70)
                                .background(Color.gray)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            Text("\(num2)")
                                .padding()
                                .frame(width:70,height: 70)
                                .background(Color.gray)
                                .font(.title)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        TextField("enter your answer here", text: $result)
                            .keyboardType(.decimalPad)
                            .frame(width: .infinity,height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke( Color.gray, lineWidth: 2)
                            )
                            .padding()
                        
                        
                    }
                    
                    Button(action: {
                        if result == "\(num1*num2)" {
                            playSound("correct")
                            result = ""
                            if difficultySelected == "easy" {
                                num1 = Int.random(in: 0...10)
                                num2 = Int.random(in: 0...10)
                            }
                            else if difficultySelected == "medium" {
                                num1 = Int.random(in: 0...30)
                                num2 = Int.random(in: 0...30)
                            }
                            else if difficultySelected == "hard" {
                                num1 = Int.random(in: 0...150)
                                num2 = Int.random(in: 0...150)
                            }
                            
                            
                        }
                        else{
                            playSound("incorrect")
                            result = ""
                            isGameOver = true
                        }
                        
                    }) {
                        Text("check")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    
                    
                }
                .navigationTitle("Math Game")
                .alert("False Answer", isPresented: $isGameOver) {
                    Button("Play Again") {
                        isGameOver = false
                        
                        if difficultySelected == "easy" {
                            num1 = Int.random(in: 0...10)
                            num2 = Int.random(in: 0...10)
                        }
                        else if difficultySelected == "medium" {
                            num1 = Int.random(in: 0...30)
                            num2 = Int.random(in: 0...30)
                        }
                        else if difficultySelected == "hard" {
                            num1 = Int.random(in: 0...150)
                            num2 = Int.random(in: 0...150)
                        }
                    }
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
    MathGameView()
}
