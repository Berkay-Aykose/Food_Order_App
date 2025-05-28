//
//  SwiftUIView.swift
//  OrderFood
//
//  Created by Berkay Veysel Ayköse on 22.04.2025.
//

import SwiftUI

struct BigButton: View {
    
    let title : String
    let action : () -> Void
    
    var body: some View {
        
        Button(action: action,label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.primary)
            
                Text(title)
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        })
        .frame(width: UIScreen.main.bounds.width * (0.9), height: UIScreen.main.bounds.height * (0.06))
        
    }
}

#Preview {
    BigButton(title: "deneme", action: {})
}
