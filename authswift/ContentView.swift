//
//  ContentView.swift
//  authswift
//
//  Created by Rajayogan on 27/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var authentication: AuthService
    
    var body: some View {
        VStack {
            
            Text("Logged In !!")
            Button("Sign out") {
                loginViewModel.logout(authentication: authentication)
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
