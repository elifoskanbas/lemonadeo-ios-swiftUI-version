//
//  MenuUI.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI

struct GameView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let games = ["clock","days","months","seasons","directions","math","spelling"]
    var body: some View {
       
            
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(games, id: \.self) { item in
                            NavigationLink(destination: getDestination(for: item)) {
                                VStack {
                                    Image(item)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                    Text(item.capitalized)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .padding(.top, 5)
                                }
                                .frame(maxWidth: .infinity, minHeight: 120)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Game Menu")
                .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0).ignoresSafeArea())
            
        
    }
}
    func getDestination(for item: String) -> some View {
           switch item {
           case "clock":
               return AnyView(ClockGameView())
           case "days":
               return AnyView(DaysGameView())
           case "months":
               return AnyView(MonthsGameView())
           case "seasons":
               return AnyView(SeasonsGameView())
           case "directions":
               return AnyView(DirectionsGameView())
           case "math":
               return AnyView(MathGameView())
           case "spelling":
               return AnyView(SpellingGameView())
           

           default:
               return AnyView(Text("Unknown Game"))
           }
       }
   }

#Preview {
    GameView()
}
