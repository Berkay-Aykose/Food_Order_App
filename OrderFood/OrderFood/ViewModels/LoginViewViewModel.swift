//
//  LoginViewViewModel.swift.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){}
    
    func login(){
        guard validate() else { return }
        
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
            if error != nil{
                self?.errorMessage = "Şifre veya Email Adresi Hatalı"
            }
        }
    }
    
    private func validate() -> Bool{
        
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Email Adresi Boş Geçilemez!"
            return false
        }
        
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Parola Boş Geçilemez!"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Geçerli Email Adresi Giriniz!"
            return false
        }
        
        return true
    }
}
