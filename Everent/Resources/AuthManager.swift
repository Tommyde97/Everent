//
//  AuthManager.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/7/24.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String) {
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            //Email Log In
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            //Username Log In
            print(username)
        }
    }
}
