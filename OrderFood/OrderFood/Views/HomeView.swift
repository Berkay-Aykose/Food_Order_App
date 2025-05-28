//
//  HomeView.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 23.04.2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewViewModel()
    @State private var arananYemekIsmi = ""
    @State private var secilenSiralama = "Sıralama Seçiniz..."
    let siralamaSecenekleri = [
        "Sıralama Seçiniz...",
        "Price: Ascending",
        "Price: Descending",
        "Name: A-Z",
        "Name: Z-A"
    ]
    
    var body: some View {
        GeometryReader { geometry in
            
            let ekranGenislik = geometry.size.width
            let itemGenislik = (ekranGenislik - 40) / 2
            
            // Modern arama çubuğu
            NavigationStack {
                ScrollView {
                    // Filtre picker'ı sağa yasla
                    HStack {
                        Spacer()
                        Picker("Order by", selection: $secilenSiralama) {
                            ForEach(siralamaSecenekleri, id: \.self) { secenek in
                                Text(secenek)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: secilenSiralama) { _, newValue in
                            viewModel.yemekleriSirala(siralama: newValue)
                        }
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())],spacing: 20){
                        ForEach(viewModel.yemeklerListesi) { x in
                            VStack{
                                NavigationLink(destination: FoodDetailView(yemekDetay: x)){
                                    FoodItem(yemek: x, genislik: itemGenislik)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Yemekler")
            }
            .onAppear {
                viewModel.yemkeleriYukle()
            }
            .searchable(text: $arananYemekIsmi, prompt: "Ara")
            .onChange(of: arananYemekIsmi) { _, newValue in
                viewModel.yemekAra(arananYemekIsmi: newValue)
            }
        }
    }
}

#Preview {
    HomeView()
}
