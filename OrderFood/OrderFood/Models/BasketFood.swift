//
//  BasketFood.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 24.04.2025.
//

import Foundation

struct BasketFood: Identifiable, Codable {
    var sepet_yemek_id : String
    var yemek_adi : String
    var yemek_resim_adi : String
    var yemek_fiyat : String
    var yemek_siparis_adet : String
    var kullanici_adi : String
        
    var id: String { sepet_yemek_id }
    
    init() {
        self.sepet_yemek_id = ""
        self.yemek_adi = ""
        self.yemek_resim_adi = ""
        self.yemek_fiyat  = ""
        self.yemek_siparis_adet = ""
        self.kullanici_adi = ""
    }
    
    init(sepet_yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat : String, kullanici_adi: String,yemek_siparis_adet: String) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat  = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
}

//yemek getir Sepet
class BasketFoodCevap: Codable {
    var sepet_yemekler: [BasketFood]?
    var success: Int?
}

//yemke ekle Sepet
class AddFoodCevap: Codable {
    var message: String?
    var success: Int?
}

//yemke sil Sepet
class DeleteFoodCevap: Codable {
    var message: String?
    var success: Int?
}
