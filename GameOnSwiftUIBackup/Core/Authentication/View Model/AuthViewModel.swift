//
//  AuthViewModel.swift
//  GameOnSwiftUIBackup
//
//  Created by Anaia Hoard on 21/06/2024.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        
        self.userSession = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        Task{
            await fetchUser()
        }
    }
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    /// This function create a new user in the database.
    /// - Parameters:
    ///   - email: user's email
    ///   - password: user's password
    ///   - fullName: user's full name
    func createUser(withEmail email: String, password: String, fullName: String, userName: String, height: String, weight: String, level: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email, userName: userName, height: height, weight: weight, level: level)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create account.")
        }
    }
    
    /// Signs user out
    func signOut(){
        do{
            try Auth.auth().signOut() // sign user out on backend
            self.userSession = nil // wipes out user session
            self.currentUser = nil //wipes out current user data
        }catch{
            print("DEBUG: Failed to sign out with error")
        }
    }
    func deleteAccount(){
        
    }
    func fetchUser() async {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
    func updateSettingData (data: String, setting: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        db.collection("users").document(uid).updateData([setting : data])
            //Firestore.firestore().collection("user").document(self.currentUser!.id).updateData([setting: data])
    }
    func createEvent (name: String, location: String, type: String, numberOfPlayers: String, filter: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        db.collection("events").document(uid).setData(["name": name, "location": location, "type": type, "maxNumberOfPlayers": numberOfPlayers])
    }
}
