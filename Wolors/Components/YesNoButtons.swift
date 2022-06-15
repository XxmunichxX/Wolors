//
//  YesNoButtons.swift
//  Wolors
//
//  Created by Francesco Monaco on 08/06/22.
//

import SwiftUI

struct YesNoButtons: View {
    
    var label: String
    var image: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.theme.hud)
            .frame(width: 110, height: 37)
            .shadow(color: .black.opacity(0.8), radius: 2, x: 3, y: 4)
            .overlay {
                HStack(alignment: .center) {
                    Text(label)
                        .foregroundColor(.theme.labels)
                        .font(.system(size: 15))
                        .padding(.horizontal,6)
    
                    Image(systemName: image)
                        .foregroundColor(.theme.labels)
                        .padding(.horizontal,4)
                }
                .padding()
                
            }
    }
}


struct YesNoButtons_Previews: PreviewProvider {
    static var previews: some View {
        YesNoButtons(label: "Yes", image: "heart.fill")
            .environmentObject(UserViewModel())
    }
}
