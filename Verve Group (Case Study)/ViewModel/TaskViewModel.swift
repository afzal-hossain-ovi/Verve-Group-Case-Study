//
//  TaskViewModel.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import Foundation
import CoreData
import Combine

class TaskViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    private var task: Task
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    init() {
        task = Task(context: persistenceController.container.viewContext)
        
        taskTitle = ""
        taskDescription = ""
        taskComments = ""
        creationDate = Date()
        task.project = nil
    }
    
    init(task: Task) {
        self.task = task
    }
    
    func deleteTask() {
        persistenceController.container.viewContext.delete(task)
    }
    
    func refresh() {
        objectWillChange.send()
        persistenceController.container.viewContext.rollback()
    }
    
    func save() {
        objectWillChange.send()
        persistenceController.save()
    }
    
    var id: NSManagedObjectID {
        task.objectID
    }
    
    var creationDate: Date {
        get {
            return task.taskCreationDate!
        }
        set {
            task.taskCreationDate = newValue
        }
    }
    
    var dateInString: String {
        return itemFormatter.string(from: creationDate)
    }
    
    var isCompleted: Bool {
        get {
            return task.isCompleted
        }
        set {
            task.isCompleted = newValue
        }
    }
    
    var taskTitle: String {
        get {
            return task.taskTitle!
        }
        set {
            task.taskTitle = newValue
        }
    }
    
    var taskDescription: String {
        get {
            return task.taskDescription!
        }
        set {
            task.taskDescription = newValue
        }
    }
    
    var taskComments: String {
        get {
            return task.taskComments!
        }
        set {
            task.taskComments = newValue
        }
    }
    
    var project: Project? {
        get {
            return task.project
        }
        set {
            task.project = newValue
        }
    }
    
}
