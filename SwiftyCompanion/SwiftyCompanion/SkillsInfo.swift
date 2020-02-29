//
//  SkillsInfo.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/23/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import UIKit

class SkillsInfo: UITableViewCell {

    @IBOutlet weak var skillsBar: UIProgressView!
    @IBOutlet weak var skillsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        skillsBar.transform = skillsBar.transform.scaledBy(x: 1, y: 2)
        skillsBar.layer.cornerRadius = skillsBar.frame.height / 2
        skillsBar.clipsToBounds = true
        skillsBar.layer.sublayers![1].cornerRadius = skillsBar.frame.height / 2
        skillsBar.subviews[1].clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
