//
//  HintView.swift
//  Wolors
//
//  Created by Francesco Monaco on 14/06/22.
//

import SwiftUI

struct HintView: View {
    
    @EnvironmentObject var vm: LevelViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selection = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .frame(width: 300, height: 180)
            .overlay {
                VStack {
                    Text("Hint")
                        .bold()
                        .padding()
                    
                    switch vm.guessedWords.count {
                    case 0:
                        Text("\(vm.levels[vm.selectedLevel].hints[0])")
                    case 1:
                        Text("\(vm.levels[vm.selectedLevel].hints[1])")
                    case 2:
                        Text("\(vm.levels[vm.selectedLevel].hints[2])")
                    case 3:
                        Text("\(vm.levels[vm.selectedLevel].hints[3])")
                    default:
                        Text("No Hint")
                    }
                    
                    
                    Spacer()
                }
                .foregroundColor(.theme.labels)
            }
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HintView()
            HintView().preferredColorScheme(.dark)
        }
        .environmentObject(LevelViewModel())
        .environmentObject(UserViewModel())
    }
}
