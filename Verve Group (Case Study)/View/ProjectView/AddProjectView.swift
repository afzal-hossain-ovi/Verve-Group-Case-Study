//
//  AddProjectView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import SwiftUI

struct AddProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var projectListVM: ProjectListViewModel
    @StateObject private var projectVM = ProjectViewModel()
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("name".localized)) {
                    TextField("project_name".localized, text: $projectVM.projectName)
                }
                
                Section(header: Text("project_description".localized)) {
                    TextEditor(text: $projectVM.projectDescription)
                        .frame(width: UIScreen.main.bounds.width - 75, height: 130, alignment: .topLeading)
                }
                
                Section(header: Text("Color")) {
                    ColorPicker("Cell Color", selection: $projectVM.projectCellColor)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("add_project".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    doneButton
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("error_title".localized), message: Text("project_error_message"), dismissButton: .default(Text("submit_button_title".localized)))
            }
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            if projectVM.projectName.isEmpty {
                showingAlert = true
            } else {
                projectListVM.addNewProject(projectVM: projectVM)
                projectListVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(projectListVM: ProjectListViewModel())
    }
}
