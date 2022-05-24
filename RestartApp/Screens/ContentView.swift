//
//  ContentView.swift
//  RestartApp
//
//  Created by Codemaker on 22/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true;
    var body: some View {
        ZStack{
            if isOnboardingViewActive{
                OnBoardingView()
            }else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
