//
//  ClockGameView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//
import SwiftUI

struct ClockGameView: View {
    @State var minute = 0
    @State var hour = 0
    @State var hourAnswer: String = ""
    @State var minuteAnswer: String = ""
    @State var resultMessage: String = ""
    @State var resultColor: Color = .black
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Saat kadranı ve akrep/yeleovan
                    ZStack {
                        Image("clocklearning")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .padding()

                        GeometryReader { geometry in
                            let size = min(geometry.size.width, geometry.size.height)
                            let centerX = geometry.size.width / 2
                            let centerY = geometry.size.height / 2

                            // Yelkovan
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 2, height: size * 0.35)
                                .offset(y: -size * 0.175)
                                .rotationEffect(Angle.degrees(Double(minute) * 6))
                                .position(x: centerX, y: centerY)

                            // Akrep
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 4, height: size * 0.25)
                                .offset(y: -size * 0.125)
                                .rotationEffect(Angle.degrees(Double(hour % 12) * 30 + Double(minute) / 2))
                                .position(x: centerX, y: centerY)
                        }
                        .frame(width: 250, height: 250)
                    }

                    // Dijital saat ve input alanı
                    ZStack {
                        Image("digitalClock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 500, height: 100)
                            .padding(.top)

                        HStack {
                            TextField("HH", text: $hourAnswer)
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 2)
                                )

                            Text(":")
                                .font(.title)

                            TextField("MM", text: $minuteAnswer)
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                        }
                    }

                    // Sonuç mesajı
                    if !resultMessage.isEmpty {
                        Text(resultMessage)
                            .font(.headline)
                            .foregroundColor(resultColor)
                            .padding()
                    }

                    // Kontrol Butonu
                    Button(action: {
                        checkAnswer()
                    }) {
                        Text("Check")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    // Yeni saat üretme butonu
                    Button(action: {
                        generateRandomTime()
                    }) {
                        Text("New Time")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Clock Game")
            .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0).ignoresSafeArea())
            .onAppear {
                generateRandomTime()
            }
        }
    }
    
    // Rastgele saat üretme
    func generateRandomTime() {
        minute = Int.random(in: 0...59)
        hour = Int.random(in: 0...23)
        hourAnswer = ""
        minuteAnswer = ""
        resultMessage = ""
    }
    
    // Cevabı kontrol etme
    func checkAnswer() {
        let trimmedHour = hourAnswer.trimmingCharacters(in: .whitespaces)
        let trimmedMinute = minuteAnswer.trimmingCharacters(in: .whitespaces)
        
        if let userHour = Int(trimmedHour), let userMinute = Int(trimmedMinute) {
            if userHour == hour && userMinute == minute {
                resultMessage = "🎉 Doğru cevap!"
                resultColor = .green
            } else {
                resultMessage = "❌ Wrong answer.True time: \(String(format: "%02d", hour)):\(String(format: "%02d", minute))"
                resultColor = .red
            }
        } else {
            resultMessage = "Please enter valid time."
            resultColor = .red
        }
    }
}

#Preview {
    ClockGameView()
}
