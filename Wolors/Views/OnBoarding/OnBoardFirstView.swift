//
//  OnBardFirstView.swift
//  Wolors
//
//  Created by Francesco Monaco on 13/06/22.
//

import SwiftUI

struct OnBoardView: View {
    
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack{
                TabView(selection : $selection) {
                    ForEach(0..<3) { _ in
                    
                        switch selection {
                        case 0:
                            Text("Page1")
                        case 1:
                            Text("Page2")
                        case 2:
                            Text("Page3")
                        default:
                            Text("Out of range")
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
    }
}

struct OnBoardFirstView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnBoardView()
            OnBoardView().preferredColorScheme(.dark)
        }
    }
}
