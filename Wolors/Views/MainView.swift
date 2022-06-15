//
//  MainView.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI
import AVFoundation

struct MainView: View {
    
    @EnvironmentObject var vm: LevelViewModel
    @EnvironmentObject var user: User
    
    @Binding var currentGameState: GameState
    
    let colorOne: LinearGradient = LinearGradient(colors: [.theme.bigPlanetFirst, .theme.bigPlanetSecond], startPoint: .leading, endPoint: .trailing)
    
    let colorTwo: LinearGradient = LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing)
    
    let colorThree: LinearGradient = LinearGradient(colors: [.indigo.opacity(0.7), .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
    
    let screen = UIScreen.main.bounds
    
    @State var player: AVAudioPlayer?
    
    @State var music: AVAudioPlayer!
    
    @State var positionXFirstPlanet = 0
    @State var positionXSecondPlanet = 0
    @State var positionXThirdPlanet = 0
    @State var positionYFirstPlanet = 0
    @State var positionYSecondPlanet = 0
    
    @State var resetOffset: CGFloat = UIScreen.main.bounds.maxY
    
    @State var resetYes = false
    @State var resetNo = false
    
    @State var levelSelected = 0
    
    @State var levelXposition:CGFloat = 200
    @State var levelYposition:CGFloat = 200
    
    @State var opacity:Double = 1
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            Planets
            
            ZStack{
                MenuView(opacity: $opacity)
            }
            .zIndex(opacity)
            .opacity(opacity == 0 && !resetNo ? 0 : 1)
            
            Levels
                .opacity(opacity == 1 || resetNo ? 0 : 1)
            
            ForEach(vm.levels, id:\.id) { level in
                // TO DO: USE A SWITCH
                if vm.selectedLevel == 1 {
                    LevelButton(selectedLevel: $vm.selectedLevel, image: level.image, isSolved: level.isSolved)
                        .position(x: 200, y: 500)
                } else if vm.selectedLevel == 2 {
                    LevelButton(selectedLevel: $vm.selectedLevel, image: level.image, isSolved: level.isSolved)
                        .position(x: 150, y: 400)
                } else if vm.selectedLevel == 3 {
                    LevelButton(selectedLevel: $vm.selectedLevel, image: level.image, isSolved: level.isSolved)
                        .position(x: 120, y: 300)
                }
            }
            
            
            ResetRectView(yesPressed: $resetYes, noPressed: $resetNo)
                .offset(y: resetOffset )
                .onChange(of: user.lifes) { _ in
                    if user.lifes == 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                            withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 1)) {
                                resetOffset = 0
                            }
                        }
                    } else {
                        withAnimation(.spring(response: 1, dampingFraction: 1, blendDuration: 1)){
                            resetOffset = UIScreen.main.bounds.maxY
                        }
                    }
                }
                .onChange(of: resetNo) { newValue in
                    withAnimation {
                        resetOffset = UIScreen.main.bounds.maxY
                        opacity = 1
                    }
                }
            
            VStack {
                HStack {
                   // HudShape(label: "\(user.coins)", image: "circle.circle")
                    HudShape(label: "\(user.lifes)", image: "heart.fill")
                    Spacer()
                    Group {
                        Button(action: {}){
                            Image(systemName: "star.circle")
                        }
                        Button(action: {}) {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                    .font(.system(size: 22))
                    .foregroundColor(.theme.labels)
                }
                .padding()
                .opacity(opacity == 1 ? 0 : 1)
                Spacer()
                
            }
        }
    }
}



extension MainView {
    private var Planets: some View {
        Group {
            Planet(heigth: 500, width: 500, color: colorOne)
                .position(x: screen.minX+30, y: screen.maxY+100)
                .offset(x: CGFloat(positionXFirstPlanet), y: CGFloat(positionYFirstPlanet))
                .onAppear {
                    withAnimation(.linear(duration: 15).repeatForever(autoreverses: true)) {
                        positionXFirstPlanet += 20
                        positionYFirstPlanet = -20
                    }
                }
            
            Planet(heigth: 150, width: 150, color: colorTwo)
                .position(x: screen.minX, y: screen.maxY-200)
                .offset(x: CGFloat(positionXSecondPlanet), y: CGFloat(positionYSecondPlanet))
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                        positionXSecondPlanet += 30
                    }
                }
            
            Planet(heigth: 150, width: 150, color: colorThree)
                .position(x: screen.maxX, y: screen.midY-100)
                .offset(x: CGFloat(positionXThirdPlanet))
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                        positionXThirdPlanet -= 40
                    }
                }
            Planet(heigth: 40, width: 40, color: colorOne)
                .position(x: 30, y: 200)
            Planet(heigth: 20, width: 20, color: colorTwo)
                .position(x: 230, y: 10)
            Planet(heigth: 20, width: 20, color: colorThree)
                .position(x: 100, y: 400)
            Planet(heigth: 10, width: 10, color: colorThree)
                .position(x: 30, y: 300)
            Planet(heigth: 30, width: 30, color: colorOne)
                .position(x: 300, y: 450)
            Planet(heigth: 10, width: 10, color: colorOne)
                .position(x: 330, y: 220)
        }
    }
}

extension MainView {
    private var Levels: some View {
        Group {
            LevelButton(selectedLevel: .constant(0), image: vm.levels[levelSelected].image, isSolved: vm.levels[levelSelected].isSolved)
                .position(x: vm.levels[levelSelected].isSolved ? 300 : UIScreen.main.bounds.midX, y: vm.levels[levelSelected].isSolved ? 650 : UIScreen.main.bounds.midY)
            
            LevelButton(selectedLevel: .constant(1), image: vm.levels[levelSelected].image, isSolved: vm.levels[levelSelected].isSolved)
                .position(x: vm.levels[levelSelected].isSolved ? 200 : UIScreen.main.bounds.midX, y: vm.levels[levelSelected].isSolved ? 530 : UIScreen.main.bounds.midY)
                .opacity(vm.levels[1].isSolved ? 1 : 0)
            
            LevelButton(selectedLevel: .constant(2), image: vm.levels[levelSelected].image, isSolved: vm.levels[levelSelected].isSolved)
                .position(x: vm.levels[levelSelected].isSolved ? 180 : UIScreen.main.bounds.midX, y: vm.levels[levelSelected].isSolved ? 400 : UIScreen.main.bounds.midY)
                .opacity(vm.levels[2].isSolved ? 1 : 0)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(currentGameState: .constant( .mainScreen))
            MainView(currentGameState: .constant( .mainScreen)).preferredColorScheme(.dark)
        }
        .environmentObject(User())
        .environmentObject(LevelViewModel())
    }
}
