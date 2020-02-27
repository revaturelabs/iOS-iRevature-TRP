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

class LoginViewController: UIViewController, UITextFieldDelegate
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
        
        textFieldPassword.delegate = self
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textFieldPassword.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        textFieldPassword.resignFirstResponder()
        self.view.endEditing(true)
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
                
                //Inserts Date to the persistence layer after the user logs in
                self.dataManager!.insertTrainerToDatabase()
                self.dataManager!.insertRoomToDatabase()
                self.dataManager!.insertLocationToDatabase()
            }
        })
    }
}
