//
//  ResetRectView.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import SwiftUI

struct ResetRectView: View {
    
    @EnvironmentObject var user:UserViewModel
    
    @State var answer = ""
    
    @Binding var yesPressed: Bool
    @Binding var noPressed: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .frame(width: 300, height: 180)
            .shadow(color: .theme.darkShadow, radius: 3, x: 8, y: 8)
            .overlay {
                VStack {
                    Text("Want to play again?")
                        .foregroundColor(.theme.labels)
                        .bold()
                        .padding()
                        .padding(.vertical,10)
                    Spacer()
                    HStack {
                        Button(action: {yesPressed.toggle();
                            user.lifes = 3;
                        }) {
                            YesNoButtons(label: "Yes", image: "heart.fill")
                        }
                        Spacer()
                        // RETURN TO MENU
                        Button(action:{noPressed.toggle();
                        }) {
                           YesNoButtons(label: "No", image: "x.circle.fill")
                        }
                    }
                    .foregroundColor(.theme.labels)
                    .padding()
                    .padding(.horizontal)
                }
            }
    }
}

struct OldGuessView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResetRectView(yesPressed: .constant(false), noPressed: .constant(false))
                .previewLayout(.fixed(width: 400, height: 300))
            ZStack {
                Color.theme.background
                ResetRectView(yesPressed: .constant(false), noPressed: .constant(false))
                    .preferredColorScheme(.dark)
            }
            .previewLayout(.fixed(width: 400, height: 300))
        }
        .environmentObject(UserViewModel())
    }
}
