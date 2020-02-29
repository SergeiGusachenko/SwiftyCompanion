//
//  Skills.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/22/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import Foundation
import  UIKit
class Skills: UITableViewCell {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var skillsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        progressBar.layer.cornerRadius = progressBar.frame.height / 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = progressBar.frame.height / 2
        progressBar.subviews[1].clipsToBounds = true
    }
}
