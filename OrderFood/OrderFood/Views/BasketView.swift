//
//  BasketView.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 23.04.2025.
//

import SwiftUI

struct BasketView: View {
    
    @StateObject var viewModel = BasketViewViewModel()
    @StateObject var profileViewViewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                if viewModel.sepetYemeklerListesi.isEmpty {
                    VStack {
                        Image(systemName: "cart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("Sepetiniz Boş")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    }
                } else {
                    VStack {
                        List {
                            ForEach(viewModel.sepetYemeklerListesi, id: \.sepet_yemek_id) { yemek in
                                let adet = Int(yemek.yemek_siparis_adet) ?? 0
                                let fiyat = Int(yemek.yemek_fiyat) ?? 0
                                let toplam = adet * fiyat
                                
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)")) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90, height: 90)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 90, height: 90)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(yemek.yemek_adi)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        HStack {
                                            Text("Adet:")
                                                .foregroundColor(.gray)
                                            Text("\(yemek.yemek_siparis_adet)")
                                                .foregroundColor(.primary)
                                        }
                                        .font(.subheadline)
                                        
                                        HStack {
                                            Text("Fiyat:")
                                                .foregroundColor(.gray)
                                            Text("\(toplam)₺")
                                                .foregroundColor(.primary)
                                                .fontWeight(.semibold)
                                        }
                                        .font(.subheadline)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .swipeActions{
                                    Button("Sil"){
                                        viewModel.sepetYemekSil(sepet_yemek_id: yemek.sepet_yemek_id, kullanici_adi: yemek.kullanici_adi)
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        
                        // Toplam ve Satın Al Butonu
                        VStack(spacing: 12) {
                            HStack {
                                Text("Toplam Tutar:")
                                    .font(.headline)
                                Spacer()
                                Text("\(viewModel.sepetYemeklerListesi.reduce(0) { $0 + (Int($1.yemek_siparis_adet) ?? 0) * (Int($1.yemek_fiyat) ?? 0) })₺")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                NavigationLink(destination: CardView(
                                    totalPrice: viewModel.sepetYemeklerListesi.reduce(0) {
                                        $0 + (Int($1.yemek_siparis_adet) ?? 0) * (Int($1.yemek_fiyat) ?? 0)
                                    })) {
                                    Text("Satın Al")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                }
                            }.padding(.horizontal)

                        }
                        .padding(.vertical)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Sepetim")
            .onAppear {
                viewModel.sepetiYukle(kullanici_adi: profileViewViewModel.user?.name ?? "")
            }
        }
    }
}

#Preview {
    BasketView()
}
