//
//  NewTaskButtonView.swift
//  Devote
//
//  Created by Nonato Sousa on 26/12/23.
//

import SwiftUI

struct GradientButtonView: View {
    @State var buttonName = "New Task"
    
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                Image(systemName: "plus.circle")
                Text(buttonName)
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .font(.title2)
            .padding()
            .background(backgroundGradient)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(color: .black.opacity(0.3), radius: 12)
        }

    }
}

#Preview {
    GradientButtonView(buttonAction: {})
}
