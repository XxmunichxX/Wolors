//
//  GuessView.swift
//  Wolors
//
//  Created by Francesco Monaco on 07/06/22.
//

import SwiftUI

struct GuessView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var user:UserViewModel
    @EnvironmentObject var vm: LevelViewModel
    
    @State var answer = ""
    
    @Binding var showSuccessAlert:Bool
    @Binding var showWrongAlert: Bool
    @Binding var showGameOver: Bool
    @Binding var alreadyGuessed: Bool
    @Binding var keyboardTrigger: Bool
    
    @FocusState private var keyboardFocused: Bool
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 320, height: 50)
            .foregroundColor(.theme.hud)
            .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .white, radius: 3, x: -4, y: -4)
            .shadow(color: .theme.darkShadow, radius: 3, x: 4, y: 4)
            .overlay {
                TextField("What is it?", text: $answer, onCommit: hideKeyboard)
                    .foregroundColor(.theme.labels)
                    .focused($keyboardFocused)
                    .padding()
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x:10)
                            .foregroundColor(.gray)
                            .opacity(answer.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                answer = ""
                            }
                        , alignment: .trailing
                    )
                    .onSubmit {
                        if vm.levels[vm.level.selectedLevel].answers.contains(answer.capitalized) {
                            showSuccessAlert.toggle()
                            if let index = vm.levels[vm.level.selectedLevel].answers.firstIndex(of: answer.capitalized) {
                                vm.levels[vm.level.selectedLevel].answers.remove(at: index)
                            }
                            vm.guessedWords.append(answer.capitalized)
                            answer = ""
                        } else if vm.guessedWords.contains(answer.capitalized) {
                            alreadyGuessed.toggle()
                            answer = ""
                        } else if user.user.lifes == 1 && !vm.levels[vm.level.selectedLevel].answers.contains(answer.capitalized) {
                            showGameOver.toggle()
                            user.user.lifes -= 1
                            answer = ""
                        } else {
                            showWrongAlert.toggle()
                            answer = ""
                        }
                    }
                    .onChange(of: keyboardTrigger) { _ in
                        keyboardFocused = true
                    }
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.theme.background)
                    .shadow(color: .white.opacity(0.3), radius: 2, x: 0, y: 0)
            )
    }
}


extension GuessView {
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}


struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GuessView(showSuccessAlert: .constant(false), showWrongAlert: .constant(false), showGameOver: .constant(false), alreadyGuessed: .constant(false), keyboardTrigger: .constant(false))
                .previewLayout(.fixed(width: 450, height: 300))
            
            ZStack {
                Color.theme.background.ignoresSafeArea()
                GuessView(showSuccessAlert: .constant(false), showWrongAlert: .constant(false), showGameOver: .constant(false), alreadyGuessed: .constant(false), keyboardTrigger: .constant(false))
                    .preferredColorScheme(.dark)
            }
            .previewLayout(.fixed(width: 450, height: 300))
            
        }
        .environmentObject(UserViewModel())
    }
}
