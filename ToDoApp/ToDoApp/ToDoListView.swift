//
//  ToDoListView.swift
//  ToDoApp
//
//  Created by Yuriy Drokin on 2023-08-24.
//

import SwiftUI

struct ToDoListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.title, ascending: true)],animation: .default)
    private var toDos: FetchedResults<ToDo>
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(toDos){ listedToDo in
                    NavigationLink(destination: Text(listedToDo.title!).font(.largeTitle).padding()){
                        Text(listedToDo.title!)
                            .lineLimit(1) // show only 1 line in the row
                    }
                 
                    
                }
                .onDelete(perform: deleteItems)
            }
                .navigationTitle("ToDoApp")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        NavigationLink(destination: AddToDoView()){
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
        }
        
    }




private func deleteItems(offsets: IndexSet) {
    withAnimation {
        offsets.map { toDos[$0] }.forEach(viewContext.delete)

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
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
