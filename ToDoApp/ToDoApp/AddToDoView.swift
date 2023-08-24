//
//  AddToDoView.swift
//  ToDoApp
//
//  Created by Yuriy Drokin on 2023-08-24.
//

import SwiftUI

struct AddToDoView: View {
    //
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    //
    
    // variable to hold string
    @State var toDoTitle = "";
    @FocusState var titleFocus: Bool
    
    var body: some View {
        VStack{
            
      
        TextField("Type any word here", text: $toDoTitle)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .focused($titleFocus)
            .submitLabel(.go) // add new button go in the keyboard
            .onSubmit { // submit button in keyboard works
                addToDO()
            }
            .padding()
            .toolbar{
                Button(action: {
                   addToDO()
                    
                }) {
                    Text("Add to List");
                }
            }
            .onAppear(){ // code run as soon as code shows up
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ // for keyboard to show up
                    titleFocus = true
                }
            
            }
            Spacer()
        }
    }
    func addToDO(){
        let newToDo = ToDo(context: viewContext)
        newToDo.title = toDoTitle;
        
        // save our data
        do {
            try viewContext.save(); // do try catch, if it doesnt work it will erroring
            // when we saved we navigate to previous view
            presentationMode.wrappedValue.dismiss();
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddToDoView()
        }
       
    }
}
