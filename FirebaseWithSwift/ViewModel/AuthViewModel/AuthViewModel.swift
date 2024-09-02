//
//  AuthViewModel.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import Foundation


final class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
        getCurrentUser()
    }
    
    //MARK: Get current User
    func getCurrentUser() {
        self.user = authRepository.getCurrentUser()
    }
    
    //MARK: Create New User
    func createNewUser(email: String, password: String) {
        authRepository.createnewUser(email: email,
                                     password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    //MARK: Login User
    func login(email: String, password: String) {
        authRepository.login(email: email,
                             password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
                
            }
            
        }
    }
    
    
    //MARK: LogOut User
    func logout() {
        do {
            try authRepository.logout()
            self.user = nil
        } catch {
            print("Error logout")
        }
    }
}
