//
//  ViewController.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 22/6/23.
//

import UIKit

final class FirstScreenController: UIViewController {
    
    @IBOutlet private weak var shortGoalButton: UIButton!
    
    @IBOutlet private weak var longGoalButton: UIButton!
    
    @IBOutlet private weak var achievedButton: UIButton!
    
    @IBOutlet private weak var describingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtonEffects.applyShadowAndPressEffect(to: shortGoalButton)
        ButtonEffects.applyShadowAndPressEffect(to: longGoalButton)
        ButtonEffects.applyShadowAndPressEffect(to: achievedButton)
        

        describingLabel.text = "Set new goals for yourself! Whether it's short-term or long-term goals, this app will help you keep track of your goals, break long-term goals into smaller tasks, and see the progress of achievement. And also this app will help you not to forget everything you have achieved, as you can always look and praise yourself for it :)"
    }


    @IBAction private func shortGoalButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ToShort", sender: self)
        
    }
    
    @IBAction private func longGoalButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toLong", sender: self)
        
    }
    
    
    @IBAction private func achievedButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toAchieved", sender: self)
        
    }
    
}

