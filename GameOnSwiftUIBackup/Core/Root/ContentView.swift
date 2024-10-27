//
//  ContentView.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 11/06/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    
    var body: some View {
        if viewModel.userSession != nil{
            MapView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
