//
//  NewTaskInputView.swift
//  Devote
//
//  Created by Nonato Sousa on 26/12/23.
//

import SwiftUI

struct NewTaskInputView: View {
    @Binding var taskName: String
    @AppStorage("isLightMode") private var isLightMode = true;
    
    var onInputSelectedAction: (Bool) -> Void
    var onAddTask: () -> Void
    
    private var isButtonDisabled: Bool {
        return taskName.isEmpty
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 25) {
                TextField(
                    "New Task",
                    text: $taskName
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .background(isLightMode ? Color(UIColor.secondarySystemBackground) : Color(UIColor.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(backgroundColor)
                .font(.system(.title3, design: .rounded, weight: .bold))
                .onChange(of: taskName) { newValue in
                    //                    handleButtonActivation()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .onTapGesture(perform: {
                    onInputSelectedAction(true)
                })
                
                Button {
                    onAddTask()
                } label: {
                    
                    Spacer()
                    Text("SAVE")
                        .padding()
                        .foregroundStyle(.white)
                        .font(.system(.title3, weight: .bold))
                    Spacer()
                }
                .background(isButtonDisabled ? .gray : backgroundColor)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .padding(.horizontal)
                .disabled(isButtonDisabled)
            }//VStack
            .padding(.bottom, 20)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(isLightMode ? .white : Color(UIColor.secondarySystemBackground))
                    .shadow(color: .black.opacity(0.3), radius: 12)
            }
            .frame(maxWidth: 640)
            .padding()
        }
    }
}

#Preview {
    NewTaskInputView(taskName: .constant(""), onInputSelectedAction: {_ in}, onAddTask: {})
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(.blue)
        .ignoresSafeArea()
}
