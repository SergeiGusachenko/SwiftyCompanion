//
//  SkillsTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/23/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
            progress.transform = progress.transform.scaledBy(x: 1, y: 2)
            progress.layer.cornerRadius = progress.frame.height / 2
            progress.clipsToBounds = true
            progress.layer.sublayers![1].cornerRadius = progress.frame.height / 2
            progress.subviews[1].clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
