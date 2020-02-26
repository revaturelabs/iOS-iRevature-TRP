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
    
    var userInfoBusinessService: UserInfoBusinessService = UserInfoBusinessService()
    
    var activeUser : User?
    #warning("more to abstract to service layer")
    var locations = [APILocation]()
    var trainers = [Trainer]()
    var skills = [Skill]()
    var rooms = [Room]()
    
    var api = RevatureAPI()
    
    var dataManager : EntityManager?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataManager = dataManagerDelegate.manager
        
        if dataManager!.verifyPreviousLogin() == true
        {
            switchKeepMeSignedIn.isOn = dataManager!.activeUser!.keepLoggedIn
            
            textFieldEmail.text = dataManager!.activeUser!.email
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
            
            // if success = true, perform the segue
            // otherwise the value returned is false, caused by invalid authentication
        })
        
        self.api.performLogin(email: username, password: password, finish:
        {
            user in
            
            #warning("We should abstract this logic out to another business function for clarity (also, some SOLID -> clarified. do it as a service layer")
            self.activeUser = User(firstName: "", lastName: "", primaryLocation: user.primaryLocation, email: username, keepLoggedIn: self.switchKeepMeSignedIn.isOn, loginToken: user.loginToken, currentRole: user.currentSystemRole)

            if (self.activeUser?.currentRole != nil)
            {
                #warning("should change the logic here so we're not calling a bool result when we dont need/use it")
                self.userInfoBusinessService.setUserInfo(userObject: self.activeUser!)
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "LandingPage") as UIViewController
                
                self.navigationController?.pushViewController(mainNavigationVC, animated: true)
                
                self.labelInvalidUsernamePassword.isHidden = true
            }
            else
            {
                self.labelInvalidUsernamePassword.isHidden = false
            }
        })
    }
}
