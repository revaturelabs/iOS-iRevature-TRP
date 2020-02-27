//
//  RevatureRoomViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/27/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
    {
    
    let dataManagerDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dataManager : EntityManager?

    // MARK: IBOutlets for UIView References
    
    @IBOutlet weak var campusTableView : RevatureCampusTableView!
    @IBOutlet weak var locationTableView : RevatureLocationTableView!
    @IBOutlet weak var roomTableView : RevatureRoomTableView!
    
    @IBOutlet weak var labelCampus : UILabel!
    @IBOutlet weak var labelLocation : UILabel!
    @IBOutlet weak var labelRoom : UILabel!
    
    //MARK: Placeholder containers for data that will be pulled from the API/DB
    
    var trainerList : [Trainer]?
    var campusList : [Campus]?
    var roomList : [Room]?
    var locationList : [Location]?
    var uniqueStates : [String]?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataManager = dataManagerDelegate.manager

        trainerList = self.dataManager!.getTrainerList()
        campusList = self.dataManager!.getCampusList()
        roomList = self.dataManager!.getRoomList()
        locationList = self.dataManager!.getLocationList()
        
        uniqueStates = uniqueLocations()
        
        campusTableView.delegate = self
        locationTableView.delegate = self
        roomTableView.delegate = self
        
        campusTableView.dataSource = self
        locationTableView.dataSource = self
        roomTableView.dataSource = self
        
        labelCampus.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelCampus.layer.borderWidth = 1
        labelLocation.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelLocation.layer.borderWidth = 1
        labelRoom.layer.borderColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.007843137255, alpha: 1)
        labelRoom.layer.borderWidth = 1
         
        campusTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        locationTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        roomTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.navigationItem.title = "Rooms"
        // Do any additional setup after loading the view.
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
            return roomList!.count
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
            //let cell = RevatureCampusCell()
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCampusCell", for: indexPath) as! RevatureCampusCell

            cell.prototypeLabel!.text = campusList![indexPath.row].campus

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeLocationCell", for: indexPath) as! RevatureLocationCell
            
            cell.prototypeLabel!.text = uniqueStates![indexPath.row]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeRoomCell", for: indexPath) as! RevatureRoomCell
            
            cell.prototypeLabel!.text = roomList![indexPath.row].room
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: tableViewCell click interaction
    /// This method indicates what to do per cell when a cell is clicked within the tableView. In this instance, we instantiate a RevatureRoomViewController and populate it with the specific room details for the selected room.
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        let selectedTrainer = trainerList![indexPath.row]
//
//        #error("change for room")
//
//        if let viewController = storyboard?.instantiateViewController(identifier: "TrainerDetails") as? RevatureTrainerDetailsViewController
//        {
//            viewController.trainerReference = selectedTrainer
//            navigationController?.pushViewController(viewController, animated: true)
//        }
//    }
}
