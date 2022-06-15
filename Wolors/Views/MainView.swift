//
//  MainView.swift
//  Wolors
//
//  Created by Francesco Monaco on 06/06/22.
//

import SwiftUI
import AVFoundation

struct MainView: View {
    
    /*
     WHAT DO I NEED TO STORE:
        Username
        SelectedLevel
        Lifes number
        gameState
     */
    
    @EnvironmentObject var vm: LevelViewModel
    @EnvironmentObject var user: User
    
    @Binding var currentGameState: GameState
    
    let planetColors = PlanetColors()
    
    let screen = UIScreen.main.bounds
    
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
    
    @State var opacity: Double = 1
    
    @State var showSettings = false
    @State var settingsOffset: CGFloat = UIScreen.main.bounds.maxY+100
    
    @State var moreToComeOffset: CGFloat = UIScreen.main.bounds.maxY+100
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            Planets
            
            ZStack{
                MenuView(opacity: $opacity)
            }
            .zIndex(opacity)
            .opacity(opacity == 0 && !resetNo ? 0 : 1)
            .onAppear {
                currentGameState = .mainScreen
            }
            
            Levels
                .opacity(opacity == 1 || resetNo ? 0 : 1)
                .onAppear {
                    currentGameState = .playing
                }
            
            // MARK: LEVEL BUTTONS
            
            ForEach(vm.levels, id:\.id) { level in
                
                switch vm.selectedLevel {
                case 1:
                    LevelButton(selectedLevel: $vm.selectedLevel, image: level.image, isSolved: level.isSolved)
                        .position(x: 200, y: 500)
                case 2:
                    LevelButton(selectedLevel: $vm.selectedLevel, image: level.image, isSolved: level.isSolved)
                        .position(x: 150, y: 400)
                case 3:
                    LevelButton(selectedLevel: $vm.selectedLevel, image: level.image, isSolved: level.isSolved)
                        .position(x: 120, y: 300)
                default:
                    Text("")
                }
            }
            
            // MARK: SETTINGS
            
            SettingsView()
                .offset(y: showSettings ? 0 : settingsOffset)
            
            MoreToCome
                .offset(y: withAnimation(.spring()) {
                    vm.selectedLevel > 0 ? 0 : moreToComeOffset
                })
            
            // MARK: RESET
            
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
            
            // MARK: HUD
            
            VStack {
                HStack {
                    HudShape(label: "\(user.lifes)", image: "heart.fill")
                    Spacer()
                    Group {
                        Button(action: {}){
                            Image(systemName: "star.circle")
                        }
                        Button(action: {withAnimation(.spring()){ showSettings.toggle()};
                            AudioManager.shared.startPlayer(track: "softpop")
                        }) {
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
        .onAppear {
            
        }
    }
}



extension MainView {
    private var Planets: some View {
        Group {
            Planet(heigth: 500, width: 500, color: planetColors.colorOne)
                .position(x: screen.minX+30, y: screen.maxY+100)
                .offset(x: CGFloat(positionXFirstPlanet), y: CGFloat(positionYFirstPlanet))
                .onAppear {
                    withAnimation(.linear(duration: 15).repeatForever(autoreverses: true)) {
                        positionXFirstPlanet += 20
                        positionYFirstPlanet = -20
                    }
                }
            
            Planet(heigth: 150, width: 150, color: planetColors.colorTwo)
                .position(x: screen.minX, y: screen.maxY-200)
                .offset(x: CGFloat(positionXSecondPlanet), y: CGFloat(positionYSecondPlanet))
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                        positionXSecondPlanet += 30
                    }
                }
            
            Planet(heigth: 150, width: 150, color: planetColors.colorThree)
                .position(x: screen.maxX, y: screen.midY-100)
                .offset(x: CGFloat(positionXThirdPlanet))
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                        positionXThirdPlanet -= 40
                    }
                }
            Planet(heigth: 40, width: 40, color: planetColors.colorOne)
                .position(x: 30, y: 200)
            Planet(heigth: 20, width: 20, color: planetColors.colorTwo)
                .position(x: 230, y: 10)
            Planet(heigth: 20, width: 20, color: planetColors.colorThree)
                .position(x: 100, y: 400)
            Planet(heigth: 10, width: 10, color: planetColors.colorThree)
                .position(x: 30, y: 300)
            Planet(heigth: 30, width: 30, color: planetColors.colorOne)
                .position(x: 300, y: 450)
            Planet(heigth: 10, width: 10, color: planetColors.colorOne)
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

extension MainView {
    private var MoreToCome: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .frame(width: 300, height: 380)
            .shadow(color: .theme.darkShadow, radius: 3, x: 4, y: 4)
            .shadow(color: .theme.lightShadow, radius: 3, x: -4, y: -4)
            .overlay {
                VStack {
                    Text("Thank you for playing! \n\nMore levels are coming soon!")
                        .bold()
                        .font(.title)
                        .foregroundColor(.theme.labels)
                        .multilineTextAlignment(.center)
                        .padding()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.theme.labels)
                        .font(.system(size: 50))
                        .padding()
                }
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
