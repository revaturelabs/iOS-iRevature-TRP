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
    
    var userName: String = "Wes"
    var password: String = "pass"
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        navigateToLanding(email: textFieldEmail.text ?? "", pass: textFieldPassword.text ?? "")
    }
    
    private func navigateToLanding(email: String, pass: String){
        if(userName == email && password == pass){
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "LandingPage") as? UIViewController else {
                return
            }
            mainNavigationVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            present(mainNavigationVC, animated: true, completion: nil)
            
        } else {
            print("Not logged in")
        }
    }
}
