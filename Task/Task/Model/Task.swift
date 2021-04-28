//
//  Task.swift
//  Task
//
//  Created by Cameron Stuart on 12/29/20.
//

import Foundation

//MARK: - Properties
class Task: Codable {
    var name: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    
    //MARK: - Initializer
    // By passing in a default value of an false into our initializer for our isComplete property, upon creation all Tasks will have the isComplete property set to false.
    init(name: String, notes: String?, dueDate: Date?, isComplete: Bool = false) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}

//MARK: - Extension
// conforms our Task to Equatable so we can compare two instances of Task to determine whether they are the same Task.  Checks all properties of the tasks and returns true only if all properties are the same.
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.notes == rhs.notes && lhs.dueDate == rhs.dueDate && lhs.isComplete == rhs.isComplete
    }
}
