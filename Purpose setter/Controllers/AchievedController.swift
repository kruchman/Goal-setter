//
//  AchievedController.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 5/7/23.
//

import UIKit
import CoreData

final class AchievedController: UITableViewController {
    
    @IBOutlet weak private var achievedGoalCounter: UILabel!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var goalArray = [LongGoal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

        loadGoals()
        
        achievedGoalCounter.text = "Total goals achieved: \(goalArray.count)"
        
    }
    
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        goalArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomTableViewCell
        let goal = goalArray[indexPath.row]
        cell.customTextLabel.text = goal.title
        cell.checkMarkImgCell.isHidden = false
        
            return cell
    }

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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
        let predicate = NSPredicate(format: "done == %@", NSNumber(value: true))
        request.predicate = predicate
        
        do {
            goalArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        
    }
   
    
}
