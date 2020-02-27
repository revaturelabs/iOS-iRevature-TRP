//
//  TrainerWorkflowViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TrainerWorkflowViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let dataManagerDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dataManager : EntityManager?
    
    // MARK: IBOutlets for UIView References
    
    @IBOutlet weak var campusTableView: RevatureCampusTableView!
    @IBOutlet weak var locationTableView: RevatureLocationTableView!
    @IBOutlet weak var skillsTableView: RevatureSkillsTableView!
    @IBOutlet weak var trainerTableView: RevatureTrainerTableView!
    
    @IBOutlet weak var labelCampus: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelSkills: UILabel!
    @IBOutlet weak var labelTrainer: UILabel!
    
    //MARK: Placeholder containers for data that will be pulled from the API/DB
    
    var trainerList : [Trainer]?
    var campusList : [Campus]?
    var locationList : [Location]?
    var skillList : [Skill]?
    var uniqueStates : [String]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataManager = dataManagerDelegate.manager
        
        trainerList = self.dataManager!.getTrainerList()
        campusList = self.dataManager!.getCampusList()
        locationList = self.dataManager!.getLocationList()
        skillList = self.dataManager!.getSkillList()
        
        uniqueStates = uniqueLocations()
        
        campusTableView.delegate = self
        trainerTableView.delegate = self
        locationTableView.delegate = self
        skillsTableView.delegate = self
        
        campusTableView.dataSource = self
        trainerTableView.dataSource = self
        locationTableView.dataSource = self
        skillsTableView.dataSource = self
        
        labelCampus.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelCampus.layer.borderWidth = 1
        labelLocation.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelLocation.layer.borderWidth = 1
        labelSkills.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelSkills.layer.borderWidth = 1
        labelTrainer.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelTrainer.layer.borderWidth = 1
         
        campusTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        trainerTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        locationTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        skillsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.navigationItem.title = "Trainers"
    }
    
    func uniqueLocations() -> [String]
    {
        var tempList = [String]()
        
        for location in locationList!
        {
            if tempList.contains(location.state) == false
            {
                tempList.append(location.state)
            }
        }

        return tempList
    }
    
    // MARK: number of rows per section functions
    /// Methods will each return the number of objects within their array list for setting the number of rows for their respective sections.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        switch(tableView.tag)
        {
        case 0:
            return campusList!.count
        case 1:
            return uniqueStates!.count
        case 2:
            return skillList!.count
        case 3:
            return trainerList!.count
        default:
            return 0
        }
    }
    
    // MARK: tableViewCell instantiation extensions
    /// These are meant to instantiate the type of Revature Table View Cells that match for the Table View type they are meant to show as each cell in each tale view type will be populated by a different collection.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        switch(tableView.tag)
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCampusCell", for: indexPath) as! RevatureCampusCell
            
            cell.prototypeLabel!.text = campusList![indexPath.row].campus
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeLocationCell", for: indexPath) as! RevatureLocationCell
            
            cell.prototypeLabel!.text = uniqueStates![indexPath.row]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeSkillCell", for: indexPath) as! RevatureSkillCell
            
            cell.prototypeLabel!.text = skillList![indexPath.row].name
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeTrainerCell", for: indexPath) as! RevatureTrainerCell
            
            cell.prototypeLabel!.text = trainerList![indexPath.row].name
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrainer = trainerList![indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "TrainerDetails") as? RevatureTrainerDetailsViewController
        {
            viewController.trainerReference = selectedTrainer
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
