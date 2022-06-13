//
//  OnBardFirstView.swift
//  Wolors
//
//  Created by Francesco Monaco on 13/06/22.
//

import SwiftUI

struct OnBoardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selection = 0
    @State private var showMenu = false
    
    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack{
                TabView(selection : $selection) {
                    ForEach(0..<3) { _ in
                        
                        switch selection {
                        case 0:
                            FirstPage
                        case 1:
                            SecondPage
                        case 2:
                            ThirdPage
                        default:
                            FirstPage
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: colorScheme == .dark ? .interactive : .always))
            }
        }
        .fullScreenCover(isPresented: $showMenu) {
            MainView(currentGameState: .constant(.mainScreen))
        }
    }
}

extension OnBoardView {
    private var FirstPage: some View {
        VStack(alignment: .center) {
            Text("Welcome to")
                .bold()
            Image(colorScheme == .dark ? "WolorsDM" : "Wolors")
            Text("We are very excited to have you here!")
                .bold()
                .multilineTextAlignment(.center)
        }
        .font(.title)
        .foregroundColor(.theme.labels)
    }
}

extension OnBoardView {
    private var SecondPage: some View {
        VStack {
            Text("\"Without leaps of imagination we lose the excitement of possibilities\" \n\nYet sometimes it is hard to imagine: maybe we can help with that.")
                .bold()
                .font(.title)
                .foregroundColor(.theme.labels)
                .multilineTextAlignment(.center)
                .padding()
        }
        
    }
}

extension OnBoardView {
    private var ThirdPage: some View {
        VStack{
            Text("Watch the illustrations, guess the related words and be inspired by what they evoke!")
                .bold()
                .foregroundColor(.theme.labels)
                .multilineTextAlignment(.center)
            
            PlayButton
                .padding(.top,30)
            
        }
        .font(.title)
        .padding()
    }
}

extension OnBoardView {
    private var PlayButton: some View {
        Button(action: {showMenu.toggle(); impactHeavy.impactOccurred()}){
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 190, height: 55)
                .foregroundColor(.theme.background)
                .shadow(color: .black, radius: 2, x: 0, y: 0)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.theme.hud)
                        .frame(width: 178, height: 38)
                        .shadow(color: .black.opacity(0.8), radius: 2, x: 3, y: 4)
                        .overlay {
                            Text("Good luck!")
                                .foregroundColor(.theme.labels)
                                .padding()
                        }
                }
        }
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnBoardView()
            OnBoardView().preferredColorScheme(.dark)
        }
        .environmentObject(LevelViewModel())
        .environmentObject(User())
    }
}
