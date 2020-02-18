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
        print(switchKeepMeSignedIn.isOn)
        if let currentUserInfo: User = userInfoBusinessService.getUserInfo(){
            let email = currentUserInfo.email
            print(email)
            textFieldEmail.text = email
        }
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        #warning("Currently using dummy data from user defaults, change this logic once API implemented")
        
        let username:String = textFieldEmail.text!
        let password:String = textFieldPassword.text!
        
        authenticateUser(username: username, password: password)
        
//        navigateToLanding(username: textFieldEmail.text ?? "", password: textFieldPassword.text ?? "")
    }
    
    private func authenticateUser(username: String, password: String){
        
        #warning("uncomment this line to perform the check on user wants to be remebered or not")
        let userKeepMeSignedIn = switchKeepMeSignedIn
        
        if(username == "test@revature.com" && password == "test1"){
            
            let userInfoData: User = User(firstName: "test", lastName: "", email: username, token: "", keepLoggedIn: true)
            
            userInfoBusinessService.setUserInfo(userObject: userInfoData)
            
            //Swgues to the next story board
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
