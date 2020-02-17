//
//  ViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTrainerSegue(_ sender: Any) {
        
        performSegue(withIdentifier: "MainTrainerSegue", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


}


