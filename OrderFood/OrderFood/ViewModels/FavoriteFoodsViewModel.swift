//
//  FavoriteFoodsViewModel.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 28.05.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FavoriteFoodsViewModel : ObservableObject {
    
    func addFavoriteFood(food: FavoriteFood) {
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let favorite = FavoriteFood(id: food.id, favori_yemek_adi: food.favori_yemek_adi, favori_yemek_resim_adi: food.favori_yemek_resim_adi, favori_yemek_fiyat: food.favori_yemek_fiyat)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("favoriFood")
            .document(favorite.id)
            .setData(favorite.asDictionary())
    }
    
    func delete(id:String){
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("favoriteMovies")
            .document(id)
            .delete()
        
    }
}
