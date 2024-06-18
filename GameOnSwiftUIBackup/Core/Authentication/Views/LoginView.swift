//
//  LoginView.swift
//  GameOnSwiftUIBackup
//
//  Created by Anaia Hoard on 21/06/2024.
//


import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                // image
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                //form fields
                VStack(spacing:24){
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Enter Your Password", placeholder: "xxxxxxxx", isSecuredField: true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button
                Button{Task{
                    try await viewModel.signIn(withEmail: email, password: password)
                }} label: {HStack{
                    Text("SIGN IN")
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
                
                Spacer()
                
                //sign up button
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 5){
                        Text("Don't have an account?")
                        Text("Sign up!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
                
            }
            
        }
    }
}
// MARK: - AuthenticationFormProtocol
extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
    
    
}

#Preview {
    LoginView()
}
