//
//  MainViewViewModel.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import Foundation
import FirebaseAuth

class MainViewViewModel:ObservableObject {
    
    @Published var currentUserId : String = ""
    
    init() {
        _ = Auth.auth().addStateDidChangeListener { [weak self] _,user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn : Bool {
        return Auth.auth().currentUser != nil
    }
}
