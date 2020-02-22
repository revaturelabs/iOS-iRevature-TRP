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
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelInvalidUsernamePassword: UILabel!
    @IBOutlet weak var switchKeepMeSignedIn: UISwitch!
    
    var userInfoBusinessService: UserInfoBusinessService = UserInfoBusinessService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DatabaseOperations.init().createDatabase()
        
        if let currentUserInfo: User = userInfoBusinessService.getUserInfo(){
            
            switchKeepMeSignedIn.isOn = currentUserInfo.keepLoggedIn
            
            if currentUserInfo.keepLoggedIn == true{
        
                let email = currentUserInfo.email
                
                textFieldEmail.text = email
            } else {
                
                textFieldEmail.text = ""
                
            }
        }
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        #warning("Currently using dummy data from user defaults, change this logic once API implemented")
        
        let username:String = textFieldEmail.text!
        
        let password:String = textFieldPassword.text!
        
        authenticateUser(username: username, password: password)
        
    }
    
    private func authenticateUser(username: String, password: String){
        
        var userKeepMeSignedIn = switchKeepMeSignedIn!.isOn
        
        //MARK: Hardcoded values need to be replaced with IP call to authenticate user
        if(username == "test@revature.com" && password == "test1"){
            
//            let userInfoData: User = User(firstName: "test", lastName: "", email: username, token: "", keepLoggedIn: userKeepMeSignedIn)
            let userInfoData: User = User(firstName: "", lastName: "", email: "", token: "", keepLoggedIn: true, currentRole: SystemRole(id: 1, code: "", description: "", name: "") )
            
            userInfoBusinessService.setUserInfo(userObject: userInfoData)
            
            //Mark: Performs segue
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
