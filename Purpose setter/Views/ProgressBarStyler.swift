//
//  ProgressBarSettings.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 7/7/23.
//


import UIKit

struct ProgressBarStyler {
    static func applyStyle(to progressBar: UIProgressView) {
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 0.3)
        progressBar.progressViewStyle = .bar
        progressBar.setProgress(progressBar.progress, animated: true)
        progressBar.progressTintColor = UIColor.green // Цвет заполненной части
        progressBar.trackTintColor = UIColor.gray // Цвет незаполненной части
        progressBar.layer.masksToBounds = true
        progressBar.layer.cornerRadius = 7.0  // Закругление углов
    }
}

