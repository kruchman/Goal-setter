//
//  ProgressBarSettings.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 7/7/23.
//

import UIKit

import UIKit

struct ProgressBarStyler {
    static func applyStyle(to progressBar: UIProgressView) {
        progressBar.progressViewStyle = .bar
        progressBar.transform = CGAffineTransform(scaleX: 0.7, y: 5)
        progressBar.setProgress(progressBar.progress, animated: true)
        progressBar.progressTintColor = UIColor.green // Цвет заполненной части
        progressBar.trackTintColor = UIColor.gray // Цвет незаполненной части
        progressBar.layer.cornerRadius = 8.0 // Закругление углов
    }
}

