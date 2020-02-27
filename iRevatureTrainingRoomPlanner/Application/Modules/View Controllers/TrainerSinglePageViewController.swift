//
//  TrainerSinglePageViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TrainerSinglePageViewController: UIViewController {

    //MARK: Needs to be replaced with the view's outlet
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var trainerNameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UIButton!
    
    @IBOutlet weak var skillsLabel: UILabel!
    
    //Trainer struct we will display
    var trainer: Trainer?
    
    //Current index in the array
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
