//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Rozalia Rodichev on 7/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            updateViews(with: task)
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let taskName = taskNameTextField.text, !taskName.isEmpty,
        let taskNotes = taskNotesTextView.text, !taskNotes.isEmpty
        else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: taskName, notes: taskNotes, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: taskName, notes: taskNotes, dueDate: date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    func updateViews(with task: Task) {
        taskNameTextField.text = task.taskName
        taskNotesTextView.text = task.taskNotes
        taskDueDatePicker.date = task.dueDate ?? Date()
    
    }
}//End of class
