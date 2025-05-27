//
//  LoginViewModel.swift
//  authswift
//
//  Created by Rajayogan on 27/05/25.
//

import Foundation
import KeychainSwift

class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    
    func login(authentication: AuthService) {
        AuthService().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                authentication.updateStatus(success: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout(authentication: AuthService) {
        let keychain = KeychainSwift()
        keychain.delete("userToken")
        authentication.updateStatus(success: false)
    }
}
