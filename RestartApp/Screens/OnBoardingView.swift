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
    
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack{
                //=====================================================
                Spacer()
                VStack{
                    Text("Share.")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
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
                //=====================================================
                Spacer()
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }
                
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
                                
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewAction = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                 
                                }
                            
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                Spacer()
            }
            
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
