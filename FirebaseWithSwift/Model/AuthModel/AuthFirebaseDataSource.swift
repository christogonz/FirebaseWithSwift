//
//  AuthFirebaseDataSource.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import Foundation
import FirebaseAuth


// Model
struct User {
    let email: String
}

final class AuthFirebaseDataSource {
    
    //MARK: Get current User
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    
    //MARK: Create New User
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) {  authDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let email = authDataResult?.user.email ?? "No email"
            print("New user create with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    //MARK: Login User
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) {  authDataResult, error in
            if let error = error {
                print("Error login a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let email = authDataResult?.user.email ?? "No email"
            print("user login with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    //MARK: LogOut User
    func logout() throws {
        try Auth.auth().signOut()
    }
}
