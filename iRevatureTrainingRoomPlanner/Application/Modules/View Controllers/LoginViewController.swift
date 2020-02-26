//
//  LoginViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/13/20.
//  Modified on 2/22/20 by Jeremy Malisse
//  Copyright © 2020 admin. All rights reserved.
//
import Foundation
import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelInvalidUsernamePassword: UILabel!
    @IBOutlet weak var switchKeepMeSignedIn: UISwitch!
    
    let dataManagerDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dataManager : EntityManager?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataManager = dataManagerDelegate.manager
        
        if dataManager!.verifyPreviousLogin() == true
        {
            switchKeepMeSignedIn.isOn = dataManager!.getActiveUser()!.keepLoggedIn
            
            textFieldEmail.text = dataManager!.getActiveUser()!.email
        }
        else
        {
            textFieldEmail.text = ""
        }
    }
    
    @IBAction func actionLogin(_ sender: Any)
    {
        let username : String = textFieldEmail.text!
        
        let password : String = textFieldPassword.text!
        
        self.dataManager!.login(email: username, password: password, keepLoggedIn: self.switchKeepMeSignedIn.isOn, finish: {
            success in
            
            if success == false
            {
                self.labelInvalidUsernamePassword.isHidden = false
            }
            else
            {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "LandingPage") as UIViewController
                
                self.navigationController?.pushViewController(mainNavigationVC, animated: true)
                
                self.labelInvalidUsernamePassword.isHidden = true
            }
        })
    }
}
