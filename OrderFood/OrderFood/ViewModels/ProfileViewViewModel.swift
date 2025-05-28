import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class ProfileViewViewModel: ObservableObject {
    
    @Published var user : User?
    @Published var profileImage: Image?  // Profil fotoğrafı değişkeni burada eklendi
    
    init () {}
    
    func kullanıcıyıGetir() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId).getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.user = User(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "")
                }
            }
    }
    
    func cikisYap() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Cikis Yapma Hatası: \(error)")
        }
    }
    
    // Fotoğraf kaydetme fonksiyonu
    func profilResmiKaydet(){
        
    }
    
    // Yerel resmi yükleme fonksiyonu
    func profilResmiGetir() {
        
    }
}
