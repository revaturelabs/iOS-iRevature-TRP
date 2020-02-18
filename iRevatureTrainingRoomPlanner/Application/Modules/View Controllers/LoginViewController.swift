//
//  LoginViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/13/20.
//  Copyright © 2020 admin. All rights reserved.
//
import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    var user = User(username: "Wes", password: "pass")
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelInvalidUsernamePassword: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        navigateToLanding(username: textFieldEmail.text ?? "", password: textFieldPassword.text ?? "")
    }
    
    private func navigateToLanding(username: String, password: String){
        if(user.username == username && user.password == password){
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "LandingPage") as? UIViewController else {
                return
            }
            navigationController?.pushViewController(mainNavigationVC, animated: true)
            labelInvalidUsernamePassword.isHidden = true
            
            //TODO: log this
        } else {
            labelInvalidUsernamePassword.isHidden = false
            //TODO: log this
        }
    }
}
