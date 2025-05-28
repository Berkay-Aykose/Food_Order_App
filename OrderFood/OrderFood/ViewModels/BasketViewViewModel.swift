//
//  BasketViewViewModel.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 24.04.2025.
//

import Foundation
import Alamofire

class BasketViewViewModel : ObservableObject{
    
    @Published var sepetYemeklerListesi = [BasketFood]()
    
    func sepetEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:String, yemek_siparis_adet:String, kullanici_adi:String) {
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        let newYemek: [String: Any] = [
            "yemek_adi": yemek_adi,
            "yemek_resim_adi": yemek_resim_adi,
            "yemek_fiyat": yemek_fiyat,
            "yemek_siparis_adet": yemek_siparis_adet,
            "kullanici_adi": kullanici_adi
        ]
        
        AF.request(url, method: .post, parameters: newYemek).responseDecodable(of: AddFoodCevap.self) { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(FoodCevap.self, from: data)
                    print("Kaydedildi")
                    print("Başarı : \(cevap.success!)")
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    func sepetiYukle(kullanici_adi:String){
        let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        
        AF.request(url, method: .post, parameters: ["kullanici_adi": kullanici_adi])
            .responseDecodable(of: BasketFoodCevap.self) { response in
                if let data = response.data {
                    do {
                        let cevap = try JSONDecoder().decode(BasketFoodCevap.self, from: data)
                        if let list = cevap.sepet_yemekler {
                            DispatchQueue.main.async {
                                self.sepetYemeklerListesi = list
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
    }
    
    func sepetYemekSil(sepet_yemek_id: String, kullanici_adi: String) {
        let url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        
        let params: [String: Any] = [
            "sepet_yemek_id": sepet_yemek_id,
            "kullanici_adi": kullanici_adi
        ]
        
        AF.request(url, method: .post, parameters: params)
            .responseDecodable(of: DeleteFoodCevap.self) { response in
                if let cevap = response.value {
                    if let success = cevap.success, success == 1 {
                        print("Silme başarılı: \(cevap.message ?? "")")
                        
                        // Opsiyonel: Silme sonrası listeyi yeniden çekebilirsin
                        self.sepetiYukle(kullanici_adi: kullanici_adi)
                        
                    } else {
                        print("Silme başarısız: \(cevap.message ?? "Bilinmeyen hata")")
                    }
                }
            }
    }
}
