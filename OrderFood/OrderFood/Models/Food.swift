//
//  Food.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 23.04.2025.
//

import Foundation

struct Food: Identifiable, Codable {
    var yemek_id : String
    var yemek_adi : String
    var yemek_resim_adi : String
    var yemek_fiyat : String
    
    var id: String { yemek_id }
    
    init() {
        self.yemek_id = ""
        self.yemek_adi = ""
        self.yemek_resim_adi = ""
        self.yemek_fiyat = ""
    }
    
    init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
}

class FoodCevap: Codable {
    var yemekler: [Food]?
    var success: Int?
}

