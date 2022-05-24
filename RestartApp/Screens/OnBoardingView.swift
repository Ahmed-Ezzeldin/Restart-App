//
//  OnBoardingView.swift
//  RestartApp
//
//  Created by Codemaker on 24/05/2022.
//

import SwiftUI

struct OnBoardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewAction: Bool = true;
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
             
            Button(action: {
                isOnboardingViewAction = false
            }){
                Text("Start")
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
