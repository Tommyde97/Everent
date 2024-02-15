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
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        //Firebase auth could not create account
                        completion(false)
                        return
                    }
                    
                    //Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            //Failed to insert to database
                            completion(true)
                            return
                        }
                    }
                }
            } else {
                //Either username or email doe snot exist
                completion(false)
            }
        }
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
    
    ///Attempt to log out Firebase User
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
            
        }
    }
    public func signIn(with facebookToken: String, completion: @escaping (Bool, Error?) -> Void) {
        let credential = FacebookAuthProvider.credential(withAccessToken: facebookToken)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Failed to sign in with Facebook: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
}
