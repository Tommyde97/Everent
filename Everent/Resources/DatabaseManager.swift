//
//  DatabaseManager.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/7/24.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public

    /// Check if username and email is avaliable
    /// - Parameters
    ///    - email: String representing email
    ///    - username: String representing username
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts the user data to database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeded
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                //Succeded
                completion(true)
                return
            } else {
                //Failed
                completion(false)
                return
            }
        }
    }
}
