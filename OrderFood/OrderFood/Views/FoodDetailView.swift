//
//  FoodDetailView.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 23.04.2025.
//

import SwiftUI

struct FoodDetailView: View {
    
    @StateObject var viewModel = BasketViewViewModel()
    @StateObject var favoriteFoodsViewModel = FavoriteFoodsViewModel()
    @StateObject var profileViewViewModel = ProfileViewViewModel()
    @State private var isFavorite: Bool = false
    var yemekDetay : Food
    @State private var adet = 1
    
    var birimFiyat: Int {
        Int(yemekDetay.yemek_fiyat) ?? 0
    }
    var toplamFiyat: Int {
        birimFiyat * adet
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20){
                AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekDetay.yemek_resim_adi)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } placeholder: {
                    ProgressView()
                        .padding()
                }
                // Ad ve birim fiyat yan yana
                HStack {
                    Text(yemekDetay.yemek_adi)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(birimFiyat) TL")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                // Adet sayacı
                HStack(spacing: 30) {
                    Button(action: { if adet > 1 { adet -= 1 } }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.title)
                            .foregroundColor(.purple)
                    }
                    Text("\(adet)")
                        .font(.title2)
                        .frame(minWidth: 40)
                    Button(action: { adet += 1 }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.purple)
                    }
                }
                // Toplam fiyat
                Text("Toplam: \(toplamFiyat) TL")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.top, 8)
                Spacer()
                // Sepete ekle butonu
                Button(action: {
                    viewModel.sepetEkle(
                        yemek_adi: yemekDetay.yemek_adi,
                        yemek_resim_adi: yemekDetay.yemek_resim_adi,
                        yemek_fiyat: yemekDetay.yemek_fiyat,
                        yemek_siparis_adet: String(adet),
                        kullanici_adi: profileViewViewModel.user?.name ?? "")
                }) {
                    HStack {
                        Spacer()
                        Text("Sepete Ekle")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .navigationTitle("Ürün Detay")
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isFavorite.toggle()
                    if isFavorite == true {
                        print("Beğenildi basıldı true oldu")
                        let favorite = FavoriteFood(
                                    id: yemekDetay.yemek_id,
                                    favori_yemek_adi: yemekDetay.yemek_adi,
                                    favori_yemek_resim_adi: yemekDetay.yemek_resim_adi,
                                    favori_yemek_fiyat: yemekDetay.yemek_fiyat
                                )
                        favoriteFoodsViewModel.addFavoriteFood(food: favorite)
                    }else{
                        print("Beğenildi basıldı false oldu")

                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .black)
                        .font(.system(size: 24))
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}


#Preview {
    FoodDetailView(yemekDetay: Food(yemek_id: "1", yemek_adi: "ayran", yemek_resim_adi: "ayran", yemek_fiyat: "30"))
}
