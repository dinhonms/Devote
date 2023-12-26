//
//  BackgroundImage.swift
//  Devote
//
//  Created by Nonato Sousa on 26/12/23.
//

import SwiftUI

struct BackgroundImage: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.all)
            Image("rocket")
                .antialiased(true)
                .resizable()
                .imageScale(.large)
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(x: isAnimating ? 90 : 0)
        }
    }
}

#Preview {
    BackgroundImage(isAnimating: .constant(false))
}
