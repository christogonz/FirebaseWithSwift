//
//  RegisterEmailView.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    
    var body: some View {
        ScrollView {
            Text("Welcome")
                .font(.largeTitle)
                .padding(.top, 40)
            Text("Enter Email and Password to Register")
                .font(.title)
            
            Image(systemName: "person.fill.badge.plus")
                .font(.system(size: 150))
                .padding(.bottom, 50)
            
            TextField("Email", text: $textFieldEmail)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .keyboardType(.emailAddress)
                
            
            SecureField("Password", text: $textFieldPassword)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
            
            Button {
                authViewModel.createNewUser(email: textFieldEmail, password: textFieldPassword)
            } label: {
                Text("Create Account")
                    .frame(maxWidth: .infinity, maxHeight: 30)
            }
            .buttonStyle(.bordered)
            
            if let messageError = authViewModel.messageError {
                Text(messageError)
                    .bold()
                    .font(.body)
                    .foregroundStyle(.red)
                    .padding(.top, 20)
            }
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    RegisterEmailView(authViewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
