//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Cameron Stuart on 12/29/20.
//

import UIKit

/**
The protocol we will use to handle the update of the cell when the `completionButton` is toggled

Step One:
   - Define the protocol. This will need to interact with class level objects and define the task we want our delegate to handle.

Delegate Methods:
   - taskCelllButtonTapped(_ sender: TaskTableViewCell)

*/
protocol TaskCompletionDelegate: AnyObject {
    /**
    Delegate method for the `TaskCompletionDelegate`

    Parameters:
       - sender: The cell that that user toggled
    */
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //MARK: - Properties
    //landing pad
    var task: Task? {
        //didSet will get triggered anytime task is assigned a value.
        didSet {
            //when task gets set, we want to update the views with information from that task
            updateViews()
        }
    }
    /**
    The `delegate` or *intern* for the protocol `TaskCompletionDelegate`

    - weak: We mark this method as weak to not create a retain cycle
    - optional: We do not want to set the value of the delegate here.
    */
    weak var delegate: TaskCompletionDelegate?
    
    //MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            /// This is the call to action for the delegate. Hey intern, go get me a coffee
            delegate.taskCellButtonTapped(self)
        }
    }
    
    //MARK: - Helper Methods
    /**
     - Description: If we have a Task then the user wants to update or view that Task. In order to allow them to do that we are going to display the data from our passed task. If the task's isComplete property is set to true, we will display our "complete" image..otherwise, we want the image to be our "incomplete" image
     */
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        if task.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
} //End of class
