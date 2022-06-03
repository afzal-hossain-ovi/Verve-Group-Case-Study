//
//  ContentView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import SwiftUI
import CoreData

struct ProjectListView: View {
    @StateObject private var projectListVM = ProjectListViewModel()
    @State private var isPresented = false
    
    var body: some View {
        List {
            if projectListVM.allProjects.isEmpty {
                Text("project_empty_message".localized)
            }
            ForEach(projectListVM.allProjects, id: \.id) { project in
                NavigationLink {
                    TaskListView(projectVM: project)
                } label: {
                    ProjectCellView(projectVM: project)
                }
                .listRowBackground(project.projectCellColor)
            }
            .onDelete { indexSet in
                projectListVM.deleteProject(offsets: indexSet)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("dashboard_title".localized)
        .onAppear {
            projectListVM.getAllProjects()
        }
        .toolbar {
            addProjectButton
        }
        .sheet(isPresented: $isPresented) {
            presentSheet
        }
    }
    
    private var addProjectButton: some View {
        Button {
            self.isPresented.toggle()
        } label: {
            Label("Add Item", systemImage: "plus")
        }
    }
    
    private var presentSheet: some View {
        NavigationView {
            AddProjectView(projectListVM: projectListVM)
        }
        .onDisappear {
            self.projectListVM.refresh()
        }
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
