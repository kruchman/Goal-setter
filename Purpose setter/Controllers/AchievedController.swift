//
//  AchievedController.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 5/7/23.
//

import UIKit
import CoreData

class AchievedController: UITableViewController {
    
    
    @IBOutlet weak private var achievedGoalCounter: UILabel!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var goalArray = [LongGoal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadGoals()
        
        achievedGoalCounter.text = "Total goals achieved: \(goalArray.count)"
        
    }
    
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        goalArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "AchievedCell")
        let goal = goalArray[indexPath.row]
        cell.textLabel?.text = goal.title
        cell.contentView.layer.opacity = 0.5
        cell.accessoryType = .checkmark
        
            return cell
    }

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
//
//            self.context.delete(self.goalArray[indexPath.row])
//            self.goalArray.remove(at: indexPath.row)
//
//            self.saveItems()
//
//            completionHandler(true)
//        }
//
//        deleteAction.backgroundColor = .red
//
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = false
//
//        return configuration
//    }

    //MARK: - Model Manipulation Methods

    private func saveItems() {

        do {
            try context.save()
        } catch {
            print(error)
        }

       tableView.reloadData()
    }
    
    private func loadGoals() {
        
        let request: NSFetchRequest<LongGoal> = LongGoal.fetchRequest()
        let predicate = NSPredicate(format: "done == %@", NSNumber(value: true))
        request.predicate = predicate
        
        do {
            goalArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        
    }
   
    
}
