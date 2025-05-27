//
//  AuthService.swift
//  authswift
//
//  Created by Rajayogan on 27/05/25.
//

import Foundation
import KeychainSwift

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    
    func updateStatus(success: Bool) {
        
        DispatchQueue.main.async {
            self.isAuthenticated = success
        }
    }
    
    //Login function
    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "http://localhost:5000/api/auth/login") else {
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        let body = LoginRequestBody(email: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            let keyChain = KeychainSwift()
            keyChain.set(token, forKey: "userToken")
            
            completion(.success(token))
            
        }.resume()
    }
}
