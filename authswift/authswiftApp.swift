//
//  authswiftApp.swift
//  authswift
//
//  Created by Rajayogan on 27/05/25.
//

import SwiftUI

@main
struct authswiftApp: App {
    
    @StateObject var authentication = AuthService()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isAuthenticated {
                ContentView()
                    .environmentObject(authentication)
            }
            else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
