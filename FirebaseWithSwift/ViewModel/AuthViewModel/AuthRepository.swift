//
//  AuthRepository.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import Foundation


final class AuthRepository {
    private let authFirebaseDataSource: AuthFirebaseDataSource
    
    init(authFirebaseDataSource: AuthFirebaseDataSource = AuthFirebaseDataSource()) {
        self.authFirebaseDataSource = authFirebaseDataSource
    }
    
    //MARK: Get current User
    func getCurrentUser() -> User? {
        authFirebaseDataSource.getCurrentUser()
    }
    
    //MARK: Create New User
    func createnewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        authFirebaseDataSource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    //MARK: Login User
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        authFirebaseDataSource.login(email: email, password: password, completionBlock: completionBlock)
    }
    
    //MARK: LogOut User
    func logout() throws {
        try authFirebaseDataSource.logout()
    }
}
