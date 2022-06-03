//
//  ProjectListViewModel.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import Foundation
import Combine
import CoreData

class ProjectListViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    @Published var allProjects: [ProjectViewModel] = []
    
    func getAllProjects() {
        do {
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            allProjects = try persistenceController.container.viewContext.fetch(request).map(ProjectViewModel.init)
            allProjects.sort { $0.timestamp > $1.timestamp }
        } catch {
            print(error)
        }
    }
    
    func save() {
        persistenceController.save()
        getAllProjects()
    }
    
    func refresh() {
        persistenceController.container.viewContext.rollback()
    }
    
    func addNewProject(projectVM: ProjectViewModel) {
        projectVM.timestamp = Date()
    }
    
    func deleteProject(offsets: IndexSet) {
        offsets.map { allProjects[$0] }.forEach {
            $0.deleteProject()
        }
        save()
    }
}
