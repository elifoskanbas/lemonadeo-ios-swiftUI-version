//
//  DirectionsLearningView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI

struct DirectionsLearningView: View {
    
    let directions = ["above", "across", "around", "behind", "beside", "between", "far", "front", "inside", "near", "on", "outside", "through", "under", "up"]
    @State private var index = 0
    @State private var isGameOver = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0)
                    .ignoresSafeArea()
                
                VStack {
                            Text("Sunny is \(directions[index]) the box")
                       // .font(.bold)
                    
                    
                            Image(directions[index])
                                .resizable()
                                .frame(maxWidth: 300, maxHeight: 300)
                    HStack{
                        Button(action: {
                            if index == 0{
                                return
                            }
                            if index < directions.count - 1 {
                                index -= 1
                            } else {
                                isGameOver = true
                                
                            }
                        }) {
                            Image(systemName: "backward.circle.fill")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .padding()
                        
                        
                        
                        Button(action: {
                            
                            if index < directions.count - 1  {
                                index += 1
                            } else {
                                isGameOver = true
                            }
                        }) {
                            Image(systemName: "forward.circle.fill")
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
                }
                .navigationTitle("Spelling Game")
                .alert("You finished.", isPresented: $isGameOver) {
                    Button("Turn Back") {
                        index = 0
                    }
                } message: {
                    Text("You've learned all the directions!")
                }
            }
        }
    }

   


#Preview {
    DirectionsLearningView()
}
