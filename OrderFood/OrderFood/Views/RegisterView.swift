//
//  RegisterView.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()
    @State var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Renk
                LinearGradient(colors: [.green.opacity(0.9), .white],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)
                    
                    Text("food way")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        TextField("İsim", text: $viewModel.name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.8), radius: 4, x: 0, y: 2)
                        
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.8), radius: 4, x: 0, y: 2)
                        
                        SecureField("Şifre", text: $viewModel.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.8), radius: 4, x: 0, y: 2)
                    }
                    .padding()
                    
                    BigButton(title: "Kayıt Ol", action: viewModel.register)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    HStack {
                        Text("Zaten bir hesabın var mı?")
                            .foregroundColor(.gray)
                        NavigationLink(destination: LoginView()) {
                            Text("Giriş Yap")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }.onChange(of: viewModel.errorMessage) {
                showErrorAlert = !viewModel.errorMessage.isEmpty
            }
            .alert("Hata", isPresented: $showErrorAlert, actions: {
                Button("Tamam", role: .cancel) {
                    viewModel.errorMessage = "" // Hata mesajını sıfırla
                }
            }, message: {
                Text(viewModel.errorMessage)
            })
        }
    }
}

#Preview {
    RegisterView()
}

