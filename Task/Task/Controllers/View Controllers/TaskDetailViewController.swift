//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Cameron Stuart on 12/29/20.
//

import UIKit

class TaskDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    //MARK: - Properties
    //landing pad
    var task: Task?
    //optional date value...will only get assigned if user selects a date
    var date: Date?
    
    //MARK: - Lifecycle Methods
    //when view gets loaded, call updateViews() function to update outlets to display information on a task if one got passed in
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Making sure that we have text
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        
        //If we have a task we are going to update it
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: taskNotesTextView.text, dueDate: date)
            
        //if we don't have an entry we are going to create one
        } else {
            TaskController.shared.createTaskWith(name: name, notes: taskNotesTextView.text, dueDate: date)
        }
        //Removes the top view off of our Navigation Stack
        navigationController?.popViewController(animated: true)
    }
    
    //if user selects a date, the date property will be assigned the selected date from the date picker
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    //MARK: - Helper Methods
    //if a task gets passed in to TaskDetailViewController, we will unwrap the task, then update our outlets to display the name, notes, and date of the task.
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
        self.date = task.dueDate
    }
    
} //End of class
