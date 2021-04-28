//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Cameron Stuart on 12/29/20.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    //When the view gets loaded into memory, load any Tasks we have in our data store.
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistenceStore()
    }
    
    //Will update our table view everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will set our number of rows equal to the number of tasks we have
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cast our cell as our custom TaskTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }

        //Grabbing our task based on the index of the cell
        let task = TaskController.shared.tasks[indexPath.row]
        
        //pass self (TaskListTableViewController) in the the cell's delegate landing pad...assigning our TaskListViewController to be our TaskCompletionDelegate for our TaskTableViewCell
        cell.delegate = self
        
        //pass the selected task in to our custom cell's landing pad
        cell.task = task

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // called to delete our cell on swipe
            /// Grabs the `Task` that we want to delete
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            /// Calls the delete function on our `TaskController`
            TaskController.shared.delete(task: taskToDelete)
            /// Delete row from our tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //identifier: what segue was triggered?
        if segue.identifier == "showTaskDetail" {
            //index: what cell triggered the segue?
            //destination: where am I trying to go?
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            //object to send: What am I trying to pass?
            let task = TaskController.shared.tasks[indexPath.row]
            //object to receive it: who's going to "catch" this object?
            destination.task = task
        }
    }
    
} //End of class

extension TaskListTableViewController: TaskCompletionDelegate {
    // Conform to Button Delegate
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        // Get the task from the cell that was passed in
        guard let task = sender.task else { return }
        // Use our Model Controller to handle the isComplete Property
        TaskController.shared.toggleIsComplete(task: task)
        // Have the cell Update
        sender.updateViews()
    }
} //End of extension
