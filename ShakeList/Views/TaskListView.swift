//
//  ContentView.swift
//  Erinnerungen
//
//  Created by Jan Kott on 28.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    
    var body: some View {
      NavigationView {
        VStack(alignment: .leading) {
            List {
                ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                    TaskCell(taskCellVM: taskCellVM)
                    
                 }
                if presentAddNewItem {
                    TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) {
                        task in
                        self.taskListVM.addTask(task: task)
                        self.presentAddNewItem.toggle()
                    }
                }
            }
            Button(action: { self.presentAddNewItem.toggle() }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Neuer Artikel hinzufügen")
                    }
                }
            .padding()
            }
        .navigationBarTitle("Einkaufsliste")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }

    var body: some View {
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
            }
            TextField("Neuer Artikelname eingeben", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}
