//
//  PuzzleView.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import SwiftUI

struct PuzzleView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: LevelViewModel
    @EnvironmentObject var user: User
    
    @State var isRightGuess: Bool = false
    //@State var blurOffset:CGFloat = 28
    @State var guessOffset: CGFloat = -50
    @State var showSuccessAlert = false
    @State var showWrongAlert = false
    @State var showAnswerAlert = false
    @State var showNextLevelAlert = false
    @State var tipsShowed = false
    @State var keyboardTrigger = false
    @State var isGameOver = false
    @State var tipsOffset: CGFloat = UIScreen.main.bounds.maxY+100
    
    
    @Binding var image: String
    
    var screen = UIScreen.main.bounds
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            Image(image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            // .blur(radius: blurOffset)
            // OLD MECHS
            /*    .onLongPressGesture(minimumDuration: 0.25) { (isPressing) in
             if isPressing {
             
             } else {
             keyboardTrigger = false
             }
             
             } perform: {
             withAnimation {
             // blurOffset -= 7
             DispatchQueue.main.asyncAfter(deadline: .now()+2) {
             keyboardTrigger = true
             DispatchQueue.main.asyncAfter(deadline: .now()+1) {
             keyboardTrigger = false
             }
             if blurOffset <= 0 {
             keyboardTrigger = false
             DispatchQueue.main.asyncAfter(deadline: .now()+1) {
             showAnswerAlert.toggle()
             }
             }
             }
             }
             } */
            
            TipsView()
                .offset(y: tipsOffset)
            
            VStack {
                HStack {
                    BackButtonView()
                        .padding(.trailing,9)
                    HudShape(label: "\(vm.levels[vm.selectedLevel].answers.count)", image: "questionmark")
                        .onTapGesture {
                            tipsShowed.toggle()
                            withAnimation {
                                if tipsShowed {
                                    tipsOffset = 0
                                } else {
                                    tipsOffset = UIScreen.main.bounds.maxY+100
                                }
                            }
                        }
                    HudShape(label: "\(user.lifes)", image: "heart.fill")
                    HudShape(label: "Hint", image: "star.fill")
                }
                .padding()
                
                Spacer()
                
                GuessView(showSuccessAlert: $showSuccessAlert, showWrongAlert: $showWrongAlert, showGameOver: $isGameOver, keyboardTrigger: $keyboardTrigger)
                    .offset(y: guessOffset)
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                        withAnimation {
                            if guessOffset == -50 {
                                guessOffset -= 300
                            }
                        }
                    })
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        withAnimation {
                            guessOffset = -50
                        }
                    }
                    .alert("YAYYY! CORRECT! 😁 ", isPresented: $showSuccessAlert) {
                        Button("Great!"){
                            
                            if vm.levels[vm.selectedLevel].answers.isEmpty {
                                vm.levels[vm.selectedLevel].isSolved = true
                                vm.selectedLevel += 1
                                showNextLevelAlert.toggle()
                            }
                            user.lifes += 1
                            /* withAnimation(.linear(duration: 2)) {
                             blurOffset = 0
                             } */
                            
                        }
                    }
                    .alert("OH NO! 😩 \nThe answer is incorrect!", isPresented: $showWrongAlert) {
                        Button("Let's try again!") {
                            user.lifes -= 1
                            if user.lifes == 0 {
                                isGameOver = true
                                // SET GAME OVER
                            }
                        }
                    }
                   /* .alert("Woops! \nThe correct answer was \(vm.levels[vm.selectedLevel].image)", isPresented: $showAnswerAlert) {
                        Button("Got it 🥲") {
                            dismiss.callAsFunction()
                        }
                    } */
                    .alert("GAME OVER 😢 \nYou runned out of lifes", isPresented: $isGameOver) {
                        Button("Ok .. 🤬") {
                            dismiss.callAsFunction()
                            // GO TO MENU
                        }
                    }
                    .alert("You did it! \nLevel Completed!", isPresented: $showNextLevelAlert) {
                        Button("Let's go!"){
                            withAnimation {
                                dismiss.callAsFunction()
                                hideKeyboard()
                            }
                            vm.guessedWords.removeAll()
                            
                        }
                    }
            }
            .padding()
        }
    }
}


struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PuzzleView(image: .constant("Baloon"))
            PuzzleView(image: .constant("Baloon")).preferredColorScheme(.dark)
        }
        .environmentObject(User())
        .environmentObject(LevelViewModel())
    }
}
