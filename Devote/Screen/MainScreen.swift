//
//  ContentView.swift
//  Devote
//
//  Created by Nonato Sousa on 27/11/23.
//

import SwiftUI
import CoreData

struct MainScreen: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default)
    
    private var items: FetchedResults<Item>
    @State private var taskName = ""
    @State private var isAnimating = false
    @State private var showTaskInput = false
    
    @AppStorage("isLightMode") private var isLightMode = true
    
    private var blurRadius: Double = 8.0
    private var animResult = false;
    
    private var isButtonDisabled: Bool {
        return taskName.isEmpty
    }
    
    //MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.completion = false
            newItem.timestamp = Date()
            newItem.task = taskName
            
            do {
                try viewContext.save()
                taskName = ""
                hideKeyboard()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    fileprivate func setIsAnimating(_ isAnimating: Bool) {
        withAnimation(.easeOut(duration: 0.25)){
            self.isAnimating = isAnimating
        }
    }
    
    private func addTask() {
        addItem()
        setIsAnimating(false)
        toggleShowTaskInput()
    }
    
    private func toggleShowTaskInput() {
        self.showTaskInput.toggle()
    }
    
    private func inputSelected(isSelected: Bool) {
        setIsAnimating(isSelected)
    }
    
    //MARK: - PREVIEW
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 25) {
                    //MARK: - HEADER
                    HStack (spacing: 1) {
                        Text("Devote")
                            .fontWeight(.heavy)
                            .font(.system(.largeTitle, design: .rounded))
                            .padding(.leading)
                        Spacer()
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule()
                                    .stroke(lineWidth: 2)
                            )
                            .padding(.horizontal, 10)
                        Button(action: {
                            isLightMode.toggle()
                            playSoundAndHaptic(.Tap)
                        }, label: {
                            Image(systemName: isLightMode ? "moon.circle" : "moon.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(.trailing)
                        })
                    }
                    .foregroundStyle(.white)
                    Spacer(minLength: 80)
                    
                    //MARK: - NEW TASK BUTTON
                    GradientButtonView(buttonName: "New Task", buttonAction: toggleShowTaskInput)
                    
                    //MARK: - TASKS
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }//List
                    .scrollIndicators(.hidden)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .frame(maxWidth: 640)
                    .listStyle(.plain)
                    .shadow(color: .black.opacity(0.3), radius: 12)
                }//VStack
                .toolbar(.hidden)
                .blur(radius: showTaskInput ? blurRadius : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: animResult)
                
                //MARK: - NEW TASK ITEM
                if showTaskInput {
                    BlankView(backgroundColor: isLightMode ? .gray : .black, backgroundOpacity: isLightMode ? 0.5 : 0.3)
                        .onTapGesture {
                            withAnimation() {
                                toggleShowTaskInput()
                                setIsAnimating(false)
                            }
                        }
                    
                    NewTaskInputView(taskName: $taskName, onInputSelectedAction: inputSelected, onAddTask: addTask)
                }
            }//ZStack
            .background(
                BackgroundImage(isAnimating: $isAnimating)
                    .blur(radius: showTaskInput ? blurRadius : 0, opaque: false)
            )
        }//Navigation
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MainScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
