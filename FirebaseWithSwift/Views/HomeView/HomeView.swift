//
//  HomeView.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var linkViewModel: LinkViewModel = LinkViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome \(authViewModel.user?.email ?? "No User")")
                    .padding(.top, 32)
//                Spacer()
                
                
                LinksView(linksViewModel: linkViewModel)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Log Out") {
                    authViewModel.logout()
                }
            }
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
