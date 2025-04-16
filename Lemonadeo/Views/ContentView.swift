//
//  ContentView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State var menu = ["game", "learn"]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(menu, id: \.self) { item in
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
            .navigationTitle("Menu")
            .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0).ignoresSafeArea())
        
    
}
        
    }
    
    func getDestination(for item: String) -> some View {
           switch item {
           case "game":
               return AnyView(GameView())
           case "learn":
               return AnyView(LearnView())
           
           default:
               return AnyView(Text("Unknown"))
           }
       }
}

#Preview {
    ContentView()
}
