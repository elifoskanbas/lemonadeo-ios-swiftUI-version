//
//  LearnView.swift
//  Lemonadeo
//
//  Created by elif oskanbaş on 15.04.2025.
//

import SwiftUI

struct LearnView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let learning = ["clock","days","months","directions"]
    var body: some View {
       
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(learning, id: \.self) { item in
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
            .navigationTitle("Learn Menu")
            .background(Color(red: 219 / 255, green: 255 / 255, blue: 245 / 255, opacity: 1.0).ignoresSafeArea())
        
    
}
    }
    
    func getDestination(for item: String) -> some View {
           switch item {
           case "clock":
               return AnyView(ClockLearningView())
           case "days":
               return AnyView(DaysLearningView())
           case "months":
               return AnyView(MonthsLearningView())
                      case "directions":
               return AnyView(DirectionsLearningView())
           default:
               return AnyView(Text("Unknown Game"))
           }
       }
}

#Preview {
    LearnView()
}
