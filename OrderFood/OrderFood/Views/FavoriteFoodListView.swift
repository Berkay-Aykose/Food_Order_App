//
//  FavoriteFoodList.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 28.05.2025.
//

import SwiftUI
import FirebaseFirestore

struct FavoriteFoodsView: View {
    
    @StateObject var viewModel: FavoriteFoodsViewModel
    @FirestoreQuery var items: [FavoriteFood]
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/favoriFood")
        self._viewModel = StateObject(wrappedValue: FavoriteFoodsViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    Text("Henüz favori yemek yok.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(items) { item in
                        HStack {
                            AsyncImage(
                                url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.favori_yemek_resim_adi)")
                            ) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            }

                            VStack(alignment: .leading) {
                                Text(item.favori_yemek_adi)
                                    .font(.headline)
                                Text("\(item.favori_yemek_fiyat) TL")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.delete(id: item.id)
                            } label: {
                                Label("Sil", systemImage: "trash")
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Favori Yemekler")
        }
    }
}
