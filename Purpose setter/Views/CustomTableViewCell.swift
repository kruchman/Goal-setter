//
//  CustomTableViewCell.swift
//  Purpose setter
//
//  Created by Юрий Кручинин on 30/9/23.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImgCell: UIImageView!
    @IBOutlet weak var checkMarkImgCell: UIImageView!
    @IBOutlet weak var customTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTextLabel.numberOfLines = 0
        
        backgroundImgCell.layer.masksToBounds = true
        backgroundImgCell.layer.cornerRadius = 8.0
        backgroundImgCell.layer.shadowOffset = CGSize(width: 2.5, height: 2.0)
        backgroundImgCell.layer.shadowColor = CGColor(gray: 1.0, alpha: 0.5)
        
        checkMarkImgCell.image = UIImage(named: "checkMark")
        checkMarkImgCell.isHidden = true
    }
    
}
