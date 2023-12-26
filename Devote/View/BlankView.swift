//
//  BlancView.swift
//  Devote
//
//  Created by Nonato Sousa on 26/12/23.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(.black)
        .opacity(0.5)
        .ignoresSafeArea()
    }
}

#Preview {
    BlankView()
}
