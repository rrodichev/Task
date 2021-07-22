//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Rozalia Rodichev on 7/21/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtomTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    var task: Task?
    
    weak var delegate: TaskCompletionDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtomTapped(self)
    }
    
    // MARK: - Functions
    
    func updateViews(with task: Task) {
    
        taskNameLabel.text = task.taskName
        
        let imageName = task.isComplete ? "complete" : "incomplete"
        completionButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
