//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/4/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    var jsonData: JSON?
    var auth = Authorization()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        auth.getToken()
    }
    
    private func configureTextField(){
        loginTextField.delegate = self
    }
    
    func search() {
        if let login = loginTextField.text?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil) {
            auth.checkUser(login) {
                completion in
                if completion != nil {
                    self.jsonData = completion
                    self.performSegue(withIdentifier: "Profile", sender: nil)
                } else {
                    self.dismiss(animated: true, completion: {
                         let anotherAlert = UIAlertController(title: "This user does not exist", message: "", preferredStyle: .alert)
                         let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in
                         })
                         anotherAlert.addAction(okAction)
                         self.present(anotherAlert, animated: true, completion: nil)
                    })
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profile" {
            let new = segue.destination as! ProfileViewController
            new.data = jsonData
        }
    }
    
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) ->Bool{
        print(loginTextField.text!)
        search()
        return true
    }
}
