//
//  GameOnSwiftUIBackup.swift
//  GameOnSwiftUIBackup
//
//  Created by Anaia Hoard on 21/09/2024.
//

import SwiftUI
import Firebase

@main
struct GameOnSwiftUIBackupApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
