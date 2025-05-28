//
//  FoodItem.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 23.04.2025.
//

import SwiftUI

struct FoodItem: View {
    
    @StateObject var viewModel = BasketViewViewModel()
    @StateObject var profileViewViewModel = ProfileViewViewModel()
    
    var yemek = Food()
    var genislik = 0.0
    
    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 4)

                AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .padding()
                }
            }
            .frame(height: 150) // sabit yükseklik, opsiyonel

            HStack {
                Text("\(yemek.yemek_fiyat)TL")
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                Spacer()

                Text("+")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .onTapGesture {
                        print("\(yemek.yemek_adi) sepete eklendi")
                        viewModel.sepetEkle(yemek_adi: yemek.yemek_adi, yemek_resim_adi: yemek.yemek_resim_adi, yemek_fiyat: yemek.yemek_fiyat, yemek_siparis_adet: "1", kullanici_adi: profileViewViewModel.user?.name ?? "")
                    }
            }
            .padding(.horizontal)
            .padding(.top,2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)

    }
}
