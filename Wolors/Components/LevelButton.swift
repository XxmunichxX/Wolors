//
//  LevelButton.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI

struct LevelButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var vm = LevelViewModel()
    @EnvironmentObject var user: UserViewModel
    
    @State var offset: CGSize = .zero
    @State var showPuzzle: Bool = false
    
    @Binding var selectedLevel: Int
    
    let screen = UIScreen.main.bounds
    
    var image: String
    var isSolved:Bool
    
    var body: some View {
        Circle()
            .frame(width: 80, height: 80)
            .foregroundColor(.theme.background)
            .offset(offset)
            .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .white, radius: 3, x: -4, y: -4)
            .shadow(color: .theme.darkShadow, radius: 3, x: 8, y: 8)
            .overlay {
                Circle()
                    .stroke()
                    .foregroundColor(.gray.opacity(0.1))
                    .offset(offset)
                Text(isSolved ? "\(selectedLevel+1)" : "?")
                    .font(.system(size: 40))
                    .foregroundColor(.theme.labels)
                    .offset(offset)
            }
            .onTapGesture {
                AudioManager.shared.startPlayer(track: "softpop")
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
                if !isSolved {
                    showPuzzle.toggle()
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.spring()) {
                            if isSolved {
                                
                                offset = value.translation
                            }
                        }
                        
                    })
                    .onEnded({ value in
                        withAnimation {
                            if isSolved {
                                offset = value.predictedEndTranslation
                            }
                        }
                        
                    })
            )
            .fullScreenCover(isPresented: $showPuzzle) {
                PuzzleView(image: $vm.levels[selectedLevel].image)
            }
    }
}

struct LevelButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LevelButton(selectedLevel: .constant(0), image:"Baloon", isSolved: true)
                .previewLayout(.fixed(width: 300, height: 300))
            ZStack {
                Color.theme.background.ignoresSafeArea()
                LevelButton(selectedLevel: .constant(0), image: "Baloon", isSolved: false)
                    .preferredColorScheme(.dark)
            }
            .previewLayout(.fixed(width: 300, height: 300))
        }
        .environmentObject(UserViewModel())
        .environmentObject(LevelViewModel())
    }
}
