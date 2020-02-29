//
//  ProfileViewController.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/13/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var correctionPoints: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var skillsTable: UITableView!
    @IBOutlet weak var projectsTableView: UITableView!
    var data: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(data as Any)
        print("Here we are")
        skillsTable.layer.cornerRadius = 5
        skillsTable.clipsToBounds = true
        fetchInfo()
        if data != nil{
        loadPhoto()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if tableView == skillsTable
       {
           return data!["cursus_users"][0]["skills"].count
       }
       else
       {
           return data!["projects_users"].count
       }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if tableView == skillsTable
        {
            let cell = skillsTable.dequeueReusableCell(withIdentifier: "skill", for: indexPath) as! SkillsTableViewCell
            let skillName = data!["cursus_users"][0]["skills"][indexPath.row]["name"].string
            let skillLevel = data!["cursus_users"][0]["skills"][indexPath.row]["level"].float!
            cell.label.text = skillName! + " - level: " + String(skillLevel)
            cell.progress.progress = modf(skillLevel).1
            return cell
        }
        else
        {
            let cell = projectsTableView.dequeueReusableCell(withIdentifier: "projects", for: indexPath) as! ProjectsTableViewCell
            let projectName = data!["projects_users"][indexPath.row]["project"]["name"].string
            let projectMark = data!["projects_users"][indexPath.row]["final_mark"].float
            cell.projectStatus.text =  String(projectMark!) + "%"
            if (projectMark != nil)
            {
                cell.projects.text = projectName!
            }
            else
            {
                cell.projects.text = projectName! + " - in progress"
            }
            return cell
        }
        
    }
    
    func fetchInfo() {
        if data == nil
        {
            return;
        }
        
        if let value = data!["displayname"].string {
            name.text = value
        }
        if let value = data!["login"].string {
            nickname.text = "\(value)"
        }
        if let value = data!["phone"].string {
            mobile.text = "Mobile is " + value
        }
    
        if let value = data!["correction_point"].int {
            correctionPoints.text = "Corrections: \(value)"
        }
        
        if let value = data!["cursus_users"][0]["level"].float {
            level.text = "Level: \(Int(value)) - \(Int(modf(value).1 * 100 + 0.1))%"
            progressBar.progress = modf(value).1
        }
        if let value = data!["location"].string {
            location.text = "Available\n\(value)"
        }
        else
        {
            location.text = "Unavailable\n-"
        }
    }
    
    
    func loadPhoto() {
        if data == nil
        {
            return;
        }
        let strUrl = data!["image_url"].string!
        if let url = URL(string: strUrl) {
            if let data = NSData(contentsOf: url) {
                photo.image = UIImage(data: data as Data)
            } else {
                photo.image = #imageLiteral(resourceName: "knuckle")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
