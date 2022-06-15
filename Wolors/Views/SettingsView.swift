//
//  SettingsView.swift
//  Wolors
//
//  Created by Francesco Monaco on 15/06/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var user: User

    @Environment(\.colorScheme) var colorScheme
    
    @State private var musicOn = true
    @State private var effectsOn = true
    @State private var darkModeOn = false
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .frame(width: 300, height: 280)
            .shadow(color: .theme.darkShadow, radius: 3, x: 4, y: 4)
            .shadow(color: .theme.lightShadow, radius: 3, x: -4, y: -4)
            .overlay {
                VStack {
                    Text("Settings")
                        .bold()
                    Spacer()
                    HStack {
                        Text("Username:")
                        Spacer()
                    }
                    TextField(user.name, text: $user.name)
                    Divider()
                    Toggle("Music", isOn: $musicOn)
                    Divider()
                    Spacer()
                    
                }
                .foregroundColor(.theme.labels)
                .padding()
            }
            .onChange(of: musicOn) { _ in
                if musicOn {
                    musicOn = false
                    AudioManager.shared.stopSound()
                    print(musicOn)
                } else if !musicOn {
                    musicOn = true
                    AudioManager.shared.startBackGroundMusic()
                    print("Else if: \(musicOn)")
                }
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
            SettingsView().preferredColorScheme(.dark)
        }
        .environmentObject(User())
        .environmentObject(LevelViewModel())
    }
}
