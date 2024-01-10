//
//  ListRowItemView.swift
//  Devote
//
//  Created by Nonato Sousa on 08/01/24.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    @State private var animResult = false
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundStyle(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default, value: self.animResult)
        }
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            try? self.viewContext.save()
        })
    }
}

