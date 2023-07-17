//
//  ShortGoalsController.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 23/6/23.
//

import UIKit
import CoreData

class ShortGoalsController: UITableViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var goalArray = [ShortGoal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        loadGoals()
        
    }
    
    
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        goalArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortCell", for: indexPath)
        let goal = goalArray[indexPath.row]
        cell.textLabel?.text = goal.title
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { action, view, complitionHandler in
            
            self.context.delete(self.goalArray[indexPath.row])
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
            
            let newGoal = ShortGoal(context: self.context)
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
        
        let request: NSFetchRequest<ShortGoal> = ShortGoal.fetchRequest()
        do {
            goalArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        
    }
    
}
