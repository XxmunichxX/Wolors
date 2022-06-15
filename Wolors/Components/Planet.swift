//
//  Planet.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI

struct Planet: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var heigth: CGFloat
    var width: CGFloat
    var color: LinearGradient
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: width, height: heigth)
            .overlay {
                Circle()
                    .frame(width: width/6, height: heigth/6)
                    .foregroundColor(.white)
                    .blur(radius: 5)
                    .shadow(color: .white, radius:10, x: 0, y: 0)
                    .position(x: heigth/3, y: width/4)
            }
            .shadow(color: colorScheme == .dark ? .white : .clear, radius: 20, x: 4, y: 2)
            
    }
}

struct Planet_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Planet(heigth: 130, width: 130, color: LinearGradient(colors: [.purple, .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
                .previewLayout(.fixed(width: 300, height: 300))
            
            ZStack {
                Color.theme.background.ignoresSafeArea()
                Planet(heigth: 130, width: 130, color: LinearGradient(colors: [.purple, .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
                    .preferredColorScheme(.dark)
            }
            .previewLayout(.fixed(width: 300, height: 300))
        }
        .environmentObject(UserViewModel())
    }
}
