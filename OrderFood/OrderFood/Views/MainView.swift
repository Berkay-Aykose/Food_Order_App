//
//  MainView.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vireModel = MainViewViewModel()
    
    var body: some View {
        
        if vireModel.isSignedIn, !vireModel.currentUserId.isEmpty {
            TabView {
                HomeView()
                    .tabItem{
                        Label("home", systemImage: "house")
                    }
                
                BasketView()
                    .tabItem {
                        Label("Sepet", systemImage: "cart")
                    }
                
                FavoriteFoodsView(userId: vireModel.currentUserId)
                    .tabItem {
                        Label("Favoriler", systemImage: "heart")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                
            }
        }else {
            RegisterView()
        }
    }
}

#Preview {
    MainView()
}
