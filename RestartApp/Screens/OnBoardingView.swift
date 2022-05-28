//
//  OnBoardingView.swift
//  RestartApp
//
//  Created by Codemaker on 24/05/2022.
//

import SwiftUI

struct OnBoardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewAction: Bool = true;
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool =  false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack{
                //=====================================================
                Spacer()
                VStack{
                    Text(textTitle)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .transition(.opacity)
                        .id(textTitle)
                    Text("""
                         It's not how much we give but how
                         much love we put into giving.
                         """)
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                }
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0: -40)
                .animation(.easeOut(duration: 2), value: isAnimating  )
                //MARK: Center
                //=====================================================
                Spacer()
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 2), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 2), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2 , y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                        DragGesture()
                            .onChanged{
                                gesture in
//                                imageOffset = gesture.translation
                                if abs(imageOffset.width) <= 150 {
                                    imageOffset = gesture.translation
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 0
                                        textTitle = "Give."
                                    }
                                }
                            }.onEnded { _ in
                                imageOffset = .zero
                                withAnimation(.linear(duration: 0.25)){
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                }
                            }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating  ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                ,alignment: .bottom
                
                )
                
                Spacer()
                //=====================================================
                ZStack{
                    // 1. Background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. Call to Button
                    Text("Get Started")
                        .font(.system(.title3 , design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    
                    // 3. Caplsule
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    // 4. Circle
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24 , weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{
                                    gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded {_ in
                                    
                                    withAnimation(Animation.easeOut(duration: 0.7)){
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewAction = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                    
                                }
                            
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 2) , value: isAnimating)
                Spacer()
            }
            
        }
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
