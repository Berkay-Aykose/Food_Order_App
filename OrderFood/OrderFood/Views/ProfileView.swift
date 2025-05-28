import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    @State private var imageData: Data? = nil
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let user = viewModel.user {
                        // Profil Fotoğrafı
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            ZStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 120, height: 120)
                                if let profileImage = profileImage {
                                    profileImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110, height: 110)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .onChange(of: selectedPhoto) {
                                    viewModel.profilResmiKaydet()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 40)

                        // Kullanıcı Bilgileri Kartı
                        VStack(spacing: 0) {
                            InfoRow(title: "İsim", value: user.name)
                            Divider()
                            InfoRow(title: "E-posta", value: user.email)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)

                        Spacer()

                        // Çıkış Yap Butonu
                        Button(action: viewModel.cikisYap) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Çıkış Yap")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    } else {
                        ProgressView("Profil yükleniyor...")
                            .padding()
                    }
                }
            }
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.kullanıcıyıGetir()
            viewModel.profilResmiGetir()
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ProfileView()
}
