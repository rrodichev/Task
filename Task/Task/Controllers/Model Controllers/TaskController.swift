//
//  TaskController.swift
//  Task
//
//  Created by Rozalia Rodichev on 7/21/21.
//

import Foundation

class TaskController {
    
    //Shared Instance
    static let shared = TaskController()
    var tasks: [Task] = []
    
    
    //CRUD function
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        
        let newTask = Task(name: name, notes: notes ?? "default notes", date: dueDate)
        tasks.append(newTask)
        
        TaskController.shared.saveToPersistenceStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        
        task.taskName = name
        task.taskNotes = notes
        task.dueDate = dueDate
        
        TaskController.shared.saveToPersistenceStore()
        
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        
        TaskController.shared.saveToPersistenceStore()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        
        TaskController.shared.saveToPersistenceStore()
    }
    
    
    // MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}//End of class
