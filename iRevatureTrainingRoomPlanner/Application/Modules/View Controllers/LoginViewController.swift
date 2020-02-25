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
    var locations = [Location]()
    var trainers = [Trainer]()
    var skills = [Skill]()
    var rooms = [Room]()
    
    let api : AuthorizationAPI = AuthorizationAPI()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let currentUserInfo: User = userInfoBusinessService.getUserInfo()
        {
            switchKeepMeSignedIn.isOn = currentUserInfo.keepLoggedIn
            
            if currentUserInfo.keepLoggedIn == true
            {
                let email = currentUserInfo.email
                
                textFieldEmail.text = email
            }
            else
            {
                textFieldEmail.text = ""
            }
            
            requestAllAPI()
        }
    }
    
    func requestAllAPI()
    {
        api.requestLocations(finish:
            {
                locationCall in
                
                self.locations = locationCall.alllocation
                
                for loc in self.locations
                {
                    print("loc: \(loc)")
                }
        })
    }
    
    @IBAction func actionLogin(_ sender: Any)
    {
        let username:String = textFieldEmail.text!
        
        let password:String = textFieldPassword.text!
        
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
