//
//  Constant.swift
//  Devote
//
//  Created by Nonato Sousa on 29/11/23.
//

import Foundation
import SwiftUI

//MARK: - COMPUTED PROPERTY (= is used because it's let)
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: - UI
let backgroundColor = Color("background-color")

let backgroundGradient: LinearGradient = {
    return LinearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}()

//MARK: - HAPTICS
let haptics = UINotificationFeedbackGenerator()
