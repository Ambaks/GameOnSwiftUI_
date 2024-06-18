//
//  RegistrationView.swift
//  GameOnSwiftUIBackup
//
//  Created by Anaia Hoard on 21/06/2024.
//


import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var nextUp = false
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing:24){
                InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                InputView(text: $fullName, title: "Full Name", placeholder: "John Doe")
                    .autocorrectionDisabled()
                
                InputView(text: $password, title: "Enter Your Password", placeholder: "xxxxxxxx", isSecuredField: true)
                    
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Confirm Your Password", placeholder: "xxxxxxxx", isSecuredField: true)
                        
                    
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            
            .padding(.horizontal)
            .padding(.top, 12)
            
            NavigationStack {
                VStack {
                    Button{
                        nextUp.toggle()

                    } label: {HStack{
                        Text("SIGN UP")
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
                }
                .navigationDestination(isPresented: $nextUp) {
                    RegistrationCreationView(email: $email, password: $password, fullName: $fullName)
                             }
            }
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 5){
                    Text("Already have an account?")
                    Text("Log in!")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.system(size: 14))
            }
        }
    }
}
// MARK: - AuthenticationFormProtocol
extension RegistrationView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
        
    }
}

#Preview {
    RegistrationView()
}
