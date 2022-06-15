//
//  HudShape.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI

struct HudShape: View {
    
    var label: String
    var image: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 100, height: 40)
            .foregroundColor(.theme.background)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.theme.hud)
                    .frame(width: 80, height: 25)
                    .shadow(color: .black.opacity(0.8), radius: 2, x: 3, y: 4)
                    .overlay {
                        HStack(alignment: .center) {
                            Text(label)
                                .foregroundColor(.theme.labels)
                                .font(.system(size: label.count>1 ? 8 : 16))
                            Spacer()
                            Image(systemName: image)
                                .foregroundColor(.theme.labels)
                        }
                        .padding()
                    }
            }
    }
}

struct HudShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HudShape(label: "Hint", image: "star.fill")
                .previewLayout(.fixed(width: 300, height: 300))
            
            ZStack {
                HudShape(label: "\(3)", image: "heart.fill")
                    .preferredColorScheme(.dark)
            }
            .previewLayout(.fixed(width: 300, height: 300))
        }
        .environmentObject(UserViewModel())
    }
}
