//
//  TaskDetailsView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject var taskVM: TaskViewModel
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section {
                Text(taskVM.taskTitle)
            } header: {
                Text("title".localized)
            }
            
            Section {
                Text(taskVM.taskDescription)
                    .frame(width: UIScreen.main.bounds.width - 75, height: 130, alignment: .topLeading)
            } header: {
                Text("task_description".localized)
            }
            
            Section {
                Text(taskVM.dateInString)
            } header: {
                Text("task_create_date".localized)
            }
            
            Section {
                Text(taskVM.taskComments)
                    .frame(width: UIScreen.main.bounds.width - 75, height: 200, alignment: .topLeading)
            } header: {
                Text("task_comments".localized)
            }
            
            Section {
                Toggle(isOn: .constant(taskVM.isCompleted)) {
                    Text("task_completed".localized)
                }
            } header: {
                Text("task_review".localized)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(taskVM.taskTitle)
        .toolbar {
            editButton
        }
        .fullScreenCover(isPresented: $isPresented) {
            taskVM.refresh()
        } content: {
            NavigationView {
                EditTaskView(taskVM: taskVM)
            }
        }
    }
    
    private var editButton: some View {
        Button("Edit") {
            isPresented.toggle()
        }
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(taskVM: TaskViewModel())
    }
}
