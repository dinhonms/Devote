//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Nonato Sousa on 10/01/24.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
        }
    }
}

#Preview {
    Toggle(isOn: .constant(true), label: {
        Text("Placeholder")
    })
    .toggleStyle(CheckboxStyle())
    .padding(.horizontal)
}
