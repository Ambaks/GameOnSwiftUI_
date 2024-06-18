//
//  RegistrationCreationView.swift
//  GameOnSwiftUIBackup
//
//  Created by Anaia Hoard on 21/06/2024.
//


import SwiftUI

struct RegistrationCreationView: View {
    
    @State private var userName = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var level = ""
    @State private var nextUp = false
    @Binding var email: String
    @Binding var password: String
    @Binding var fullName: String
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
       
        VStack{
                //let user = viewModel.currentUser
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing:24){
                    
                    InputView(text: $userName, title: "User Name:", placeholder: "JohnSmoove")
                    
                    InputView(text: $height, title: "Enter your height:", placeholder: "6'2")
                    
                    InputView(text: $weight, title: "Enter your weight:", placeholder: "185")
                    
                    InputView(text: $level, title: "What level do you play at?", placeholder: "NBA, NCAA, Church league...")
                }
                .padding(.horizontal)
                .padding(.top, 12)
                NavigationStack{
                    Button{
                        Task{
                            try await viewModel.createUser(withEmail: self.email, password: self.password, fullName: self.fullName, userName: userName, height: height, weight: weight, level: level)
                            //nextUp.toggle()
                        }
                    } label: {HStack{
                        Text("CONTINUE TO APP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)
                    .navigationDestination(isPresented: $nextUp) {
                        MapView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
                
                
                Spacer()
                
            }
        }
    }


extension RegistrationCreationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !userName.isEmpty
        && !level.isEmpty
        && !height.isEmpty
        && !weight.isEmpty
    }
}

