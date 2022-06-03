//
//  AddTaskView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject private var taskVM = TaskViewModel()
    @State private var showingAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                TextField("task_title".localized, text: $taskVM.taskTitle)
            } header: {
                Text("title".localized)
            }
            
            Section {
                TextEditor(text: $taskVM.taskDescription)
                    .frame(width: UIScreen.main.bounds.width - 75, height: 130, alignment: .topLeading)
            } header: {
                Text("task_description".localized)
            }
            
            Section {
                DatePicker("task_select_date".localized, selection: $taskVM.creationDate)
            } header: {
                Text("task_create_date".localized)
            }
            
            Section {
                TextEditor(text: $taskVM.taskComments)
                    .frame(width: UIScreen.main.bounds.width - 75, height: 200, alignment: .topLeading)
            } header: {
                Text("task_comments".localized)
            }
            
            Section {
                Toggle(isOn: $taskVM.isCompleted) {
                    Text("task_completed".localized)
                }
            } header: {
                Text("task_review".localized)
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("add_task".localized)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                cancelButton
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                doneButton
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("error_title".localized), message: Text("task_error_message".localized), dismissButton: .default(Text("submit_button_title".localized)))
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            if taskVM.taskTitle.isEmpty && taskVM.taskDescription.isEmpty {
                showingAlert = true
            } else {
                projectVM.addNewTask(taskVM: taskVM)
                projectVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(projectVM: ProjectViewModel())
    }
}
