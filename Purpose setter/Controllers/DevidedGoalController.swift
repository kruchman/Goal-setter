//
//  TableViewController.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 3/7/23.
//

import UIKit
import CoreData

class DevidedGoalController: UITableViewController {

    @IBOutlet private weak var progressBar: UIProgressView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var goalArray = [DevidedGoal]()
    
    var selectedGoal: LongGoal? {
        didSet {
            loadGoals()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgressBarStyler.applyStyle(to: progressBar)
        
        tableView.delegate = self
        calculateProgress()
        
    }
    
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        goalArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DevidedCell")
        let goal = goalArray[indexPath.row]
        cell.textLabel?.text = goal.title
        
        if goal.done == true {
            cell.accessoryType = .checkmark
            cell.contentView.layer.opacity = 0.5
        } else if goal.done == false {
            cell.accessoryType = .none
        }
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        goalArray[indexPath.row].done = !goalArray[indexPath.row].done
        self.saveItems()
        
        calculateProgress()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            self.context.delete(self.goalArray[indexPath.row])
            self.goalArray.remove(at: indexPath.row)
            
            self.saveItems()
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    

    
    //MARK: - Adding New Goals
    
    @IBAction private func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Goal", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newGoal = DevidedGoal(context: self.context)
            newGoal.title = textField.text!
            newGoal.done = false
            newGoal.parentLongGoal = self.selectedGoal
            self.goalArray.append(newGoal)
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField { (alerTextField) in
            alerTextField.placeholder = "Type new goal"
            textField = alerTextField
        }
        
        present(alert, animated: true)
    }
    
    //MARK: - Model Manipulation Methods

    private func saveItems() {
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        calculateProgress()
       tableView.reloadData()
    }
    
    
    private func loadGoals() {
        
        let request: NSFetchRequest<DevidedGoal> = DevidedGoal.fetchRequest()

        let predicate = NSPredicate(format: "parentLongGoal.title MATCHES %@", selectedGoal!.title!)

        request.predicate = predicate

        do {
            goalArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        tableView.reloadData()
    }

    
    private func calculateProgress() {
        let totalTasks = goalArray.count
        let completedTasks = goalArray.filter { $0.done }.count

        if totalTasks > 0 {
            let progress = Float(completedTasks) / Float(totalTasks)
            progressBar.progress = progress
        } else {
            progressBar.progress = 0
        }
    }
    
}
