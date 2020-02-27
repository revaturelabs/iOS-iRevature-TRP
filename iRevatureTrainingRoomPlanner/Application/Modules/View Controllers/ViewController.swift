//
//  ViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func batchesComingSoon()
    {
        displayMessage(message: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    func displayMessage(message: String)
    {
        let alert = UIAlertController(title: "Coming Soon", message: "This feature is still in development. Thank you for your interest!", preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    

}


