//
//  Task.swift
//  Task
//
//  Created by Rozalia Rodichev on 7/21/21.
//

import Foundation

class Task: Codable {
    
    var taskName: String
    var taskNotes: String?
    var dueDate: Date?
    var isComplete: Bool
    let uuid: String
    
    
    init(name: String, notes: String, date: Date?, isComplete: Bool = false, uuid: String = UUID().uuidString) {
        self.taskName = name
        self.taskNotes = notes
        self.dueDate = date
        self.isComplete = isComplete
        self.uuid = uuid
    }
}//End of class

// MARK: - Extensions
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
