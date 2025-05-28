//
//  RegisterViewViewModel.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel : ObservableObject{
   
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){}
    
    func register(){
        guard validate() else { return }
        
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result , error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String){
        
        let newUser = User(id: id, name: name, email: email)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
            errorMessage = ""
            
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                errorMessage = "Lütfen tüm alanları eksiksiz doldurunuz."
                return false

            }
            
            guard email.contains("@") && email.contains(".") else {
                errorMessage = "Geçerli bir e-posta adresi giriniz."
                return false
            }
            
            guard password.count >= 8 else {
                errorMessage = "Şifreniz en az 8 karakterden oluşmalıdır."
                return false
            }
            
            return true
        }
}
