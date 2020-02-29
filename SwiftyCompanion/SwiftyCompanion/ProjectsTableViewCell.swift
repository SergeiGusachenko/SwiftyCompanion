//
//  ProjectsTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/23/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var projects: UILabel!
    @IBOutlet weak var projectStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
