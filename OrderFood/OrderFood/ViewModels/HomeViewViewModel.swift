//
//  HomeViewViewModel.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 23.04.2025.
//

import Foundation
import Alamofire

class HomeViewViewModel : ObservableObject {
    
    @Published var yemeklerListesi = [Food]()
    private var tumYemekler = [Food]() // orijinal tam liste

    func yemkeleriYukle(){
        let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"

        AF.request(url, method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(FoodCevap.self, from: data)
                    if let list = cevap.yemekler {
                        DispatchQueue.main.async {
                            self.tumYemekler = list
                            self.yemeklerListesi = list
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func yemekAra(arananYemekIsmi: String) {
        if arananYemekIsmi.isEmpty {
            self.yemeklerListesi = self.tumYemekler
        } else {
            self.yemeklerListesi = self.tumYemekler.filter {
                $0.yemek_adi.lowercased().contains(arananYemekIsmi.lowercased())
            }
        }
    }
    
    func yemekleriSirala(siralama: String) {
        switch siralama {
        case "Price: Ascending":
            self.yemeklerListesi.sort {
                (Int($0.yemek_fiyat) ?? 0) < (Int($1.yemek_fiyat) ?? 0)
            }
        case "Price: Descending":
            self.yemeklerListesi.sort {
                (Int($0.yemek_fiyat) ?? 0) > (Int($1.yemek_fiyat) ?? 0)
            }
        case "Name: A-Z":
            self.yemeklerListesi.sort { $0.yemek_adi.localizedCaseInsensitiveCompare($1.yemek_adi) == .orderedAscending }
        case "Name: Z-A":
            self.yemeklerListesi.sort { $0.yemek_adi.localizedCaseInsensitiveCompare($1.yemek_adi) == .orderedDescending }
        default:
            break
        }
    }
}
