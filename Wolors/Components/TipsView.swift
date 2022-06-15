//
//  TipsView.swift
//  Wolors
//
//  Created by Francesco Monaco on 11/06/22.
//

import SwiftUI

struct TipsView: View {
    
    @EnvironmentObject var vm: LevelViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .frame(width: 300, height: 180)
            .overlay {
                VStack {
                    Text("You have to guess \(vm.levels[vm.selectedLevel].answers.count) words")
                        .bold()
                        .padding()
                        .padding(.vertical,10)
                    Text("Words already guessed:")
                        .bold()
                        .opacity(vm.guessedWords.isEmpty ? 0 : 1)
                    HStack {
                        ForEach(vm.guessedWords, id:\.self) { word in
                            Text(word + ", ")
                        }
                    }
                    Spacer()
                }
                .foregroundColor(.theme.labels)
            }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TipsView()
            TipsView().preferredColorScheme(.dark)
        }
        .environmentObject(LevelViewModel())
    }
}
