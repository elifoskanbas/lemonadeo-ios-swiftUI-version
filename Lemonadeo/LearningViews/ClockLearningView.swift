//
//  ClockLearningView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//
import SwiftUI

struct ClockLearningView: View {
    @State var minute = 00
    @State var hour = 00
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        
                        Image("clocklearning")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300) // Daha küçük ve ortalanmış
                            .padding()

                        
                        GeometryReader { geometry in
                            let size = min(geometry.size.width, geometry.size.height)
                            let centerX = geometry.size.width / 2
                            let centerY = geometry.size.height / 2

                            
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 2, height: size * 0.35)
                                .offset(y: -size * 0.175)
                                .rotationEffect(Angle.degrees(Double(minute) * 6))
                                .position(x: centerX, y: centerY)

                            
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 4, height: size * 0.25)
                                .offset(y: -size * 0.125)
                                .rotationEffect(Angle.degrees(Double(hour % 12) * 30 + Double(minute) / 2))
                                .position(x: centerX, y: centerY)
                        }
                        .frame(width: 250, height: 250)
                    }
                    ZStack{
                        Image("digitalClock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 50)
                            .padding()
                        
                        Text("\(hour) : \(minute)")
                            .frame(width: .infinity,height: 40)
                            
                            .padding()
                    }
                    Button(action: {
                        minute = Int.random(in: 0...59)
                        hour = Int.random(in: 0...23)
                    }) {
                        Text("Generate")
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
            .navigationTitle("Learn Clocks")
            .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0).ignoresSafeArea())
        }
    }
}

#Preview {
    ClockLearningView()
}
