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
    // MARK: ignore these two calls, they should never be called in this class
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("should not be calling basic style")
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("should not be calling basic style")
        
        return UITableViewCell()
    }
    

    //MARK: Placeholder containers for data that will be pulled from the API/DB
    
    var trainerList = ["Trainer Person 1", "Trainer Person 2", "Trainer Person 3", "Trainer Person 4", "Trainer Person 5", "Trainer Person 6", "Trainer Person 7", "Trainer Person 8", "Trainer Person 9", "Trainer Person 10", "Trainer Person 11", "Trainer Person 12" ]
    
    var campusList = ["Campus Place 1", "Campus Place 2", "Campus Place 3", "Campus Place 4", "Campus Place 5", "Campus Place 6", "Campus Place 7" ]
    
    var locationList = ["Location Place 1", "Location Place 2", "Location Place 3", "Location Place 4", "Location Place 5", "Location Place 6", "Location Place 7", "Location Place 8" ]
    
    var skillList = ["Skill Thing 1", "Skill Thing 2", "Skill Thing 3", "Skill Thing 4", "Skill Thing 5", "Skill Thing 6", "Skill Thing 7" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded trainer controller view")
    }
    
    
    

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as! RevTableViewCell
//
//        cell.protoLabel!.text = list[indexPath.row]
//
//        print(" printing this: \(list[indexPath.row])")
//
//
//        return cell
//    }

    
    
}

extension TrainerWorkflowViewController {
    
    
    
    // MARK: tableViewCell instantiation extensions
    
    /// These are meant to instantiate the type of Revature Table View Cells that match for the Table View type they are meant to show as each cell in each tale view type will be populated by a different collection.
    
    func tableView(_ tableView: RevatureCampusTableView, cellForRowAt indexPath: IndexPath) -> RevatureCampusCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCampusCell", for: indexPath) as! RevatureCampusCell
        
        cell.prototypeLabel!.text = campusList[indexPath.row]
        
        print("Called revature campus table view")
        
        return cell
    }
    
    func tableView(_ tableView: RevatureLocationTableView, cellForRowAt indexPath: IndexPath) -> RevatureLocationCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeLocationCell", for: indexPath) as! RevatureLocationCell
        
        cell.prototypeLabel!.text = locationList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: RevatureSkillsTableView, cellForRowAt indexPath: IndexPath) -> RevatureSkillCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeSkillCell", for: indexPath) as! RevatureSkillCell
        
        cell.prototypeLabel!.text = skillList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: RevatureTrainerTableView, cellForRowAt indexPath: IndexPath) -> RevatureTrainerCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeTrainerCell", for: indexPath) as! RevatureTrainerCell
        
        cell.prototypeLabel!.text = trainerList[indexPath.row]
        
        return cell
    }
    
    // MARK: number of rows per section functions
    /// Methods will each return the number of objects within their array list for setting the number of rows for their respective sections.
    
    func tableView(_ tableView: RevatureCampusTableView, numberOfRowsInSection section: Int) -> Int {
        
        print("count: \(campusList.count)")
        
        return campusList.count
    }

    func tableView(_ tableView: RevatureLocationTableView, numberOfRowsInSection section: Int) -> Int {
        
        print("count: \(locationList.count)")
        
        return locationList.count
    }
    
    func tableView(_ tableView: RevatureSkillsTableView, numberOfRowsInSection section: Int) -> Int {
        
        print("count: \(skillList.count)")
        
        return skillList.count
    }
    
    func tableView(_ tableView: RevatureTrainerTableView, numberOfRowsInSection section: Int) -> Int {
        
        print("count: \(trainerList.count)")
        
        return trainerList.count
    }

}
