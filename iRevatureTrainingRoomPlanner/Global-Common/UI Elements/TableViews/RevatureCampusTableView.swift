//
//  RevatureCampusTableView.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureCampusTableView: UITableView, UITableViewDataSource {

    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCampusCell", for: indexPath) as! RevatureCampusCell
        
        //cell.prototypeLabel!.text = campusList[indexPath.row]
        
        print("Called revature campus table view")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //print("count: \(campusList.count)")

        return 5
    }
    

    //print("test")
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
