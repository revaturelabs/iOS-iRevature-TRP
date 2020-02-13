//
//  LoginViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/13/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class LogoutViewController: UIViewController{
    
    
    @IBAction func actionLogOut(_ sender: Any) {
        logOut()
    }
    
    func logOut(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "startViewController") as? UIViewController else {
            return
        }
        mainNavigationVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(mainNavigationVC, animated: true, completion: nil)
    }
    
}
