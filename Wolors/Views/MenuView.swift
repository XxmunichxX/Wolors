//
//  MenuView.swift
//  Wolors
//
//  Created by Francesco Monaco on 10/06/22.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var user: User
    @Environment(\.colorScheme) var colorScheme
    
    let colorOne: LinearGradient = LinearGradient(colors: [.theme.bigPlanetFirst, .theme.bigPlanetSecond], startPoint: .leading, endPoint: .trailing)
    
    let colorTwo: LinearGradient = LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing)
    
    let colorThree: LinearGradient = LinearGradient(colors: [.indigo.opacity(0.7), .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
    
    let screen = UIScreen.main.bounds
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    @State var positionXFirstPlanet = 0
    @State var positionXSecondPlanet = 0
    @State var positionXThirdPlanet = 0
    @State var positionYFirstPlanet = 0
    @State var positionYSecondPlanet = 0
    @State var showNameAlert = false
    
    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    
    @Binding var opacity: Double
    
    var body: some View {
        VStack{
            Spacer()
            
            Image(colorScheme == .dark ? "WolorsDM" : "Wolors")
            
            UserName
            
            PlayButton
                .padding(.top,70)
            
            Spacer()
            
        }
    }
}

extension MenuView {
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

extension MenuView {
    private var PlayButton: some View {
        Button(action:{ withAnimation(.spring()) {opacity -= 1} ;impactHeavy.impactOccurred();hideKeyboard()}) {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 120, height: 60)
                .foregroundColor(.theme.background)
                .shadow(color: .black, radius: 2, x: 0, y: 0)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.theme.hud)
                        .frame(width: 110, height: 50)
                        .shadow(color: .black.opacity(0.8), radius: 2, x: 3, y: 4)
                        .overlay {
                            Image(systemName: "play.fill")
                                .foregroundColor(.theme.labels)
                                .font(.system(size: 40))
                        }
                }
        }
        .disabled(user.name.isEmpty)
        .onTapGesture {
            if user.name.isEmpty {
                showNameAlert.toggle()
            }
        }
        .alert("You can't play \nwithout a name", isPresented: $showNameAlert) {
            Button("Make sense! 😅") {
                
            }
        }
    }
}

extension MenuView {
    private var UserName: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 320, height: 50)
            .foregroundColor(.theme.hud)
            .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .white, radius: 3, x: -4, y: -4)
            .shadow(color: .theme.darkShadow, radius: 3, x: 4, y: 4)
            .overlay {
                TextField("What's your name?", text: $user.name)
                    .foregroundColor(.theme.labels)
                    .padding()
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x:10)
                            .foregroundColor(.gray)
                            .opacity(user.name.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                user.name = ""
                            }
                        , alignment: .trailing
                    )
            }
            .padding()
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView(opacity: .constant(1))
            MenuView(opacity: .constant(1)).preferredColorScheme(.dark)
        }
        .environmentObject(User())
    }
}
