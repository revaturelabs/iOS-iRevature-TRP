//
//  RevatureTrainerDetailsViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/27/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureTrainerDetailsViewController: UIViewController
{
    // MARK: Outlet references to prototype ViewController
    
    @IBOutlet weak var labelTrainerName: UILabel!
    @IBOutlet weak var labelTrainerLocation: UILabel!
    @IBOutlet weak var buttonTrainerEmail: UIButton!
    @IBOutlet weak var labelTrainerSkills: UILabel!
    @IBOutlet weak var imageTrainerPicture: UIImageView!
    
    @IBOutlet weak var buttonAssignCurrentTrainer: UIButton!
    
    // Optional reference to trainer - This variable is set on instantiation from the method that generated this VC
    var trainerReference : Trainer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // MARK: Update visual elements based on the passed trainer reference
        
        labelTrainerName.text = trainerReference?.name
        labelTrainerLocation.text = trainerReference?.primarylocation
        buttonTrainerEmail.titleLabel?.text = trainerReference?.emailaddress
        buttonTrainerEmail.setTitle(trainerReference?.emailaddress, for: .normal)
        
        #warning("Calculated value needs to be moved into the Trainer struct as a method")
        var skillsString = ""
        
        for index in 0..<trainerReference!.skills.count
        {
            if index == trainerReference!.skills.count - 1
            {
                skillsString.append(contentsOf: "\(trainerReference!.skills[index])")
            }
            else
            {
                skillsString.append(contentsOf: "\(trainerReference!.skills[index]), ")
            }
        }
        
        labelTrainerSkills.text = skillsString
        
        if trainerReference?.profilepicture != "NO_IMAGE"
        {
            // pull picture URL and update as UIImage
            let url = URL(string: trainerReference!.profilepicture!)
            
            self.imageTrainerPicture.downloadImage(from: url!)
        }
    }
    
    
}

#warning("Add in-line documentation")
extension UIImageView
{
    // Get raw data from the URL used to retrieve the Image File
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
   {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
    
    // Handle the image data to resolve a UIImage from the URL
    func downloadImage(from url: URL)
    {
        getData(from: url)
        {
            data, response, error in
            
            guard let data = data, error == nil else
            {
                return
            }
            
            // Asynchronous load of image - why you'll notice the image doesn't appear immediately, but the TrainerDetailsVC doesn't hang on waiting for it to load.
            DispatchQueue.main.async()
            {
                self.image = UIImage(data: data)
            }
        }
    }
}
