//
//  ProjectViewModel.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class ProjectViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    private var project: Project
    
    init() {
        project = Project(context: persistenceController.container.viewContext)
        
        projectName = ""
        projectDescription = ""
        projectCellColor = .random
        project.tasks = nil
    }
    
    init(project: Project) {
        self.project = project
    }
    
    func save() {
        objectWillChange.send()
        persistenceController.save()
    }

    func deleteProject() {
        persistenceController.container.viewContext.delete(project)
    }

    func refresh() {
        objectWillChange.send()
        persistenceController.container.viewContext.rollback()
    }
    
    var id: NSManagedObjectID {
        project.objectID
    }
    
     var timestamp: Date {
        get {
            return project.timestamp!
        }
        set {
            project.timestamp = newValue
        }
    }
    
    var projectName: String {
        get {
            return project.projectName!
        }
        set {
            project.projectName = newValue
        }
    }
    
    var projectDescription: String {
        get {
            return project.projectDescription!
        }
        set {
            project.projectDescription = newValue
        }
    }
    
    var projectCellColor: Color {
        get {
            do {
                return try Color(NSKeyedUnarchiver.unarchivedObject(
                                    ofClass: UIColor.self,
                                    from: project.projectCellColor!)!)
            } catch {
                print(error)
            }
            
            return Color.clear
        }
        set {
            do {
                try project.projectCellColor = NSKeyedArchiver.archivedData(
                    withRootObject: UIColor(newValue),
                    requiringSecureCoding: false)
            } catch {
                print(error)
            }
        }
    }
    
    var tasks: [TaskViewModel] {
        let tasks = (project.tasks?.allObjects as! [Task]).map(TaskViewModel.init)
        return tasks.sorted {$0.creationDate > $1.creationDate }
    }
    
    func addNewTask(taskVM: TaskViewModel) {
        taskVM.project = project
    }
    
    func deleteTask(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach {
            $0.deleteTask()
        }
        
       save()
    }
}
