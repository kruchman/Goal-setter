//
//  TableViewController.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 3/7/23.
//

import UIKit
import CoreData

final class LongGoalsController: UITableViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var goalArray = [LongGoal]()
    
    private let achievedController = AchievedController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadGoals()
        
    }
    
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        goalArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomTableViewCell
        let goal = goalArray[indexPath.row]
        cell.customTextLabel.text = goal.title
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDevide", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! DevidedGoalController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedGoal = goalArray[indexPath.row]
        }
        
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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { [self] action, view, complitionHandler in
            
            let achievedLongGoal = goalArray[indexPath.row]
            
            if let goals = achievedLongGoal.goals?.allObjects as? [DevidedGoal] {
                       for goal in goals {
                           self.context.delete(goal)
                       }
                   }
            
            self.goalArray[indexPath.row].done = true
            
            self.achievedController.goalArray.append(achievedLongGoal)
                        
            self.goalArray.remove(at: indexPath.row)
            
            self.saveItems()
            
            complitionHandler(true)
        }
        
        doneAction.backgroundColor = .green
        
        let configuration = UISwipeActionsConfiguration(actions: [doneAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    //MARK: - Adding New Goals
    
    @IBAction private func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Goal", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newGoal = LongGoal(context: self.context)
            newGoal.title = textField.text!
            newGoal.done = false
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
        
       tableView.reloadData()
    }
    
    
    private func loadGoals() {
        
        let request: NSFetchRequest<LongGoal> = LongGoal.fetchRequest()
        
        let predicate = NSPredicate(format: "done == %@", NSNumber(value: false))
        request.predicate = predicate
                                    
        do {
            goalArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        
    }
   
}
