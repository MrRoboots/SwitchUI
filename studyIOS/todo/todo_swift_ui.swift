//
//  todo_swift_ui.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//

import Foundation
import SwiftUI


struct Todo:Identifiable{
    let id = UUID()
    let name:String
    let category:String
}

struct StudyTodoSwiftUI : View {
    
    @State private var showAddTodoView = false
    
    @State private var todos = [
        Todo(name:"Write SwiftUI book",category: "person"),
        Todo(name:"Read Bible",category: "person"),
        Todo(name:"Bring kids out to play",category: "person"),
        Todo(name:"Fetch wife",category: "person"),
        Todo(name:"family",category: "person")
    ]
    
    
    func addTodo(){
        todos.append(Todo(name:"zhangsan",category: "person"))
    }
    
    var body: some View {
        
        NavigationView(content:{
            
            List{
                ForEach(todos) { todo in
                    NavigationLink(destination: {
                        VStack{
                            Text(todo.name)
                            Image(systemName: todo.category)
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                    },label: {
                        HStack{
                            Image(systemName: todo.category).resizable().frame(width:50,height: 50)
                            Text(todo.name)
                        }
                    })
                }.onDelete(perform: { indexSet in todos.remove(atOffsets: indexSet) })//加给单个item的
                    .onMove(perform: { indices, newOffset in
                        todos.move(fromOffsets: indices, toOffset: newOffset)
                    })
            }.navigationTitle("Todo Items")
                .navigationBarItems(
                leading: Button(action: {
                    self.showAddTodoView.toggle()
                },
                                label: {
                                    Text("Add")
                                }).sheet(isPresented: $showAddTodoView){
                                    AddTodoView(showAddTodoView: self.$showAddTodoView, todos:self.$todos)
                                },
                
                //                leading: Button("Add"){
                //                    addTodo()
                //                },
                trailing: EditButton() //编辑功能
            )
            
        })
    }
}



struct AddTodoView:View{
    //绑定传入值
    @Binding var showAddTodoView: Bool
    @Binding var todos: [Todo]
    
    @State private var name: String = ""
    @State private var selectedCategory = 0
    var categoryTypes = ["family","personal","work"]
    

    
    var body: some View{
        
        VStack{
            Text("Add Todo").font(.largeTitle)
            TextField("To Do name",text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black).padding()
            
            Text("Select Category")
            Picker("",selection: $selectedCategory){
                ForEach(0 ..< categoryTypes.count,id: \.self){
                    Text(self.categoryTypes[$0])
                }
            }.pickerStyle(SegmentedPickerStyle())
        }.padding()
        
        Button(action: {
            self.showAddTodoView = false
            todos.append(Todo(name: name, category: categoryTypes[selectedCategory]))
        },
               label: {
            Text("Done")
        })
    }
    
}


struct StudyTodoSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        StudyTodoSwiftUI()
    }
}
