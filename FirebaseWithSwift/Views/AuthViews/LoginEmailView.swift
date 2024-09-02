//
//  LoginEmailView.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    
    var body: some View {
        ScrollView {
            Text("Enter Email and Password to Log In")
                .font(.largeTitle)
                .padding(.top, 40)
            Image(systemName: "exclamationmark.lock")
                .font(.system(size: 150))
                .padding(.bottom, 50)
                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            TextField("Email", text: $textFieldEmail)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .keyboardType(.emailAddress)
                
            
            SecureField("Password", text: $textFieldPassword)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
        
            
            Button {
                authViewModel.login(email: textFieldEmail, password: textFieldPassword)
            } label: {
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("Log In With Email")
                        .foregroundStyle(.white.gradient)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(.rect(cornerRadius: 30))
            }
            
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
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    LoginEmailView(authViewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
