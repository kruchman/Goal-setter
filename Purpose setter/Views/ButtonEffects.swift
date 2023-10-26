//
//  ButtonEffects.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 16/7/23.
//

import UIKit

class ButtonEffects {
    
    static func applyShadowAndPressEffect(to button: UIButton) {
        button.titleLabel?.font = UIFont(name: "IndieFlower", size: 23.0)
        // Настройка свойств тени
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4

        // Настройка внешнего вида при нажатии
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased(_:)), for: .touchUpOutside)
    }

    @objc static func buttonPressed(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }

    @objc static func buttonReleased(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }
}

