//
//  ContentView.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import SwiftUI

enum AuthSheetView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var authSheetView: AuthSheetView?
    
    
    var body: some View {
        VStack {
            Image(systemName: "figure.dance")
                .font(.system(size: 200))
            
            Spacer()
            Button {
                authSheetView = .login
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
            
            Spacer()
            
            Button {
                authSheetView = .register
            } label: {
             Text("Don´t have an Account?")
                    .foregroundStyle(.white)
             Text("Register")
                    .fontWeight(.bold)
            }
        }
        .padding()
        .sheet(item: $authSheetView) { sheet in
            switch sheet {
            case .register:
                RegisterEmailView(authViewModel: authViewModel)
            case .login:
                LoginEmailView(authViewModel: authViewModel)
            }
            
        }
        
    }
}

#Preview {
    AuthView(authViewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
