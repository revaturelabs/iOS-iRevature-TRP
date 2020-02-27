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
    
    @IBOutlet weak var imageTrainerPicture: UIImageView!
    
    @IBOutlet weak var labelTrainerName: UILabel!
    
    @IBOutlet weak var labelTrainerLocation: UILabel!
    
    @IBOutlet weak var buttonTrainerEmail: UIButton!
    
    @IBOutlet weak var labelTrainerSkills: UILabel!
    
    
//    @IBOutlet weak var profilePicture: UIImageView!
//
//    @IBOutlet weak var trainerNameLabel: UILabel!
//
//    @IBOutlet weak var locationLabel: UILabel!
//
//    @IBOutlet weak var emailLabel: UIButton!
//
//    @IBOutlet weak var skillsLabel: UILabel!
    
    //Trainer struct we will display
    var trainer: Trainer?
    
    //Current index in the array
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        
        
        labelTrainerName.text = trainer?.name
        labelTrainerLocation.text = trainer?.primarylocation
        buttonTrainerEmail.titleLabel?.text = trainer?.emailaddress
        
        buttonTrainerEmail.setTitle(trainer?.emailaddress, for: .normal)
        
        var skillsString = ""
        
        for index in 0..<trainer!.skills.count
        {
            if index == trainer!.skills.count - 1
            {
                skillsString.append(contentsOf: "\(trainer!.skills[index])")
            }
            else
            {
                skillsString.append(contentsOf: "\(trainer!.skills[index]), ")
            }
        }
        
        labelTrainerSkills.text = skillsString
        
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
