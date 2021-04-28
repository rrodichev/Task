//
//  TaskController.swift
//  Task
//
//  Created by Cameron Stuart on 12/29/20.
//

import Foundation

class TaskController {
    
    //MARK: - Properties
    //Singleton
    static let shared = TaskController()
    
    //Source of Truth (SOT)
    var tasks: [Task] = []
    
    //MARK: - CRUD Methods
    
    /**
    This function creates a `Task`
    - Parameters:
    - name: Sets the `name` of our new `Task`
    - notes: If any notes entered, will pass them in as a String into our new `Task`
    - dueDate: If a date was selected, will pass it in as a Date into our new `Task`
     Then appends `newTask` to our SOT
    */
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistenceStore()
    }
    
    /**
    This function updates a `Task`
    - Parameters:
    - task: which `Task` will be updated
    - name:  the new `name` of our `Task`
    - notes: the new `notes` of our  `Task`
    - dueDate: the new `dueDate` to our `Task`
    */
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistenceStore()
    }
    
    /**
    This function toggles the isComplete property of a `Task`
    - Parameters:
    - task: which `Task` will be toggled
    */
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    /// Used to Delete a `Task`
    /// - Parameter task: The `Task` that we want to delete
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    /**
    Used to create a file path for a location to save our data
    - Returns: A URL used to specify file location
    */
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Task.json") // <-- Change file (app) name
        return fileURL
    }
    
    /**
    Saves the current entries array as data to a file on disk
    */
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(tasks) // <-- Change S.O.T
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our tasks: \(error) -- \(error.localizedDescription)") // <-- Update error message
        }
    }
    
    /**
    Loads saved data from disk, decodes the data into an array of Entry and assigns that array to the source of truth (entries) on the Entry Controller
    */
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try jsonDecoder.decode([Task].self, from: data) // <-- Update S.O.T & Update the decoded type
        } catch {
            print("Error decoding our data into tasks: \(error) -- \(error.localizedDescription)") // <-- Update error message
        }
    }
    
} //End of class
