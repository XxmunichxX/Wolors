//
//  BackButtonView.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import SwiftUI

struct BackButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        Button(action: {dismiss.callAsFunction();
            AudioManager.shared.startPlayer(track: "softpop");
            impactHeavy.impactOccurred();
        }) {
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(.theme.hud)
                .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .white, radius: 3, x: -4, y: -4)
                .shadow(color: .theme.darkShadow, radius: 3, x: 4, y: 4)
                .overlay {
                    Circle()
                        .stroke()
                        .foregroundColor(.gray.opacity(0.1))
                    Image(systemName: "chevron.left")
                        .foregroundColor(.theme.labels)
                        .font(.system(size: 15))
                }
                .background(
                    Circle()
                        .foregroundColor(.theme.background)
                        .frame(width: 38, height: 38)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 0)
                )
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BackButtonView()
                .previewLayout(.fixed(width: 300, height: 300))
            
            ZStack {
                Color.theme.background
                BackButtonView()
                    .preferredColorScheme(.dark)
            }
            .previewLayout(.fixed(width: 300, height: 300))
        }
        .environmentObject(User())
    }
}
