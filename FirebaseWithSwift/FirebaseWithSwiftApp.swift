//
//  FirebaseWithSwiftApp.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-20.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}



@main
struct FirebaseWithSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()

    
    var body: some Scene {
        WindowGroup {
            if let _ = authViewModel.user {
                HomeView(authViewModel: authViewModel)
            } else {
                AuthView(authViewModel: authViewModel)
            }
        }
        
    }
}
