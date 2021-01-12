//
//  ContentView.swift
//  Text Shimmer
//
//  Created by David Pope on 12/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    // Toggle for multi-colours
    @State var multiColor = false
    
    var body: some View {
        VStack(spacing: 25) {
            
            TextShimmer(text: "Monzo", multiColors: $multiColor)
            
            Toggle(isOn: $multiColor, label: {
                Text("Enable colours")
                    .font(.title)
                    .fontWeight(.bold)
            }
            )
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

// TextShimmer...

struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View {
        
        ZStack{
            
            Text(text)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            
            // MultiColor Text...
            
            HStack(spacing: 0) {
                
                ForEach(0..<text.count, id: \.self){ index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(multiColors ? randomColor()
                                            : Color.white)
                }
            }
            // Masking for the shimmer effect
            .mask(
                
                Rectangle()
                    .fill(
                        
                        // You can use any Color here
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                    // Moving view constantly so it will have a shimmer effect...
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
                
            )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                    
                    animation.toggle()
                }
            })
        }
    }
    
    // Random Colour...
    
    func randomColor() -> Color {
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        return Color(color)
        
    }
    
}
