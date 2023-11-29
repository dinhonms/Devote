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
    
    private func addTask() {
        addItem()
    }
    
    //MARK: - PREVIEW
    var body: some View {
        NavigationView {
            VStack (spacing: 25) {
                TextField(
                    "New Task",
                    text: $taskName
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.gray)
                .font(.system(.title3, design: .rounded, weight: .medium))
                .onChange(of: taskName) { newValue in
                    //                    handleButtonActivation()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Button {
                    addTask()
                } label: {
                    
                    Spacer()
                    Text("SAVE")
                        .padding()
                        .foregroundStyle(.white)
                        .font(.system(.headline, weight: .semibold))
                    Spacer()
                }
                .background(isButtonDisabled ? .gray : backgroundColor)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .padding(.horizontal)
                .disabled(isButtonDisabled)
                
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading) {
                            Text(item.task ?? "")
                                .font(.headline)
                            Text(item.timestamp!, formatter: itemFormatter)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                        //Navigation link
                        //                        NavigationLink {
                        //                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        //                        } label: {
                        //                            VStack(alignment: .leading) {
                        //                                Text(item.task ?? "")
                        //                                    .font(.headline)
                        //                                Text(item.timestamp!, formatter: itemFormatter)
                        //                            }
                        //                        }
                    }
                    .onDelete(perform: deleteItems)
                }//List
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }//VStack
            .navigationTitle("Daily Tasks")
        }
    }
}

#Preview {
    MainScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
