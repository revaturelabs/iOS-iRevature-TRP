//
//  BatchDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createBatchTable(){
        
        if let batchTable = iRevatureTables.batchTable.makeStatement(){
            debugPrint(batchTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.batchTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
}
