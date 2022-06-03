//
//  TaskListView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @State private var isPresented = false
    
    var body: some View {
        List {
            if projectVM.tasks.isEmpty {
                Text("task_empty_message".localized)
            }
            ForEach(projectVM.tasks, id: \.id) { task in
                NavigationLink {
                    TaskDetailsView(taskVM: task)
                } label: {
                    TaskCellView(taskVM: task)
                }
            }
            .onDelete(perform: { indexSet in
                projectVM.deleteTask(offsets: indexSet)
            })
        }
        .listStyle(.insetGrouped)
        .navigationTitle(projectVM.projectName)
        .onAppear {
            projectVM.refresh()
        }
        .toolbar {
            addTaskButton
        }
        .sheet(isPresented: $isPresented) {
            presentSheet
        }
    }
    
    private var addTaskButton: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private var presentSheet: some View {
        NavigationView {
            AddTaskView(projectVM: projectVM)
        }
        .onDisappear {
            projectVM.refresh()
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(projectVM: ProjectViewModel())
    }
}
