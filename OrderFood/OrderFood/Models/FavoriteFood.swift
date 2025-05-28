//
//  FavoriteFood.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 28.05.2025.
//

import Foundation

struct FavoriteFood: Codable, Identifiable{
    
    let id : String
    let favori_yemek_adi : String
    let favori_yemek_resim_adi : String
    let favori_yemek_fiyat : String

}
