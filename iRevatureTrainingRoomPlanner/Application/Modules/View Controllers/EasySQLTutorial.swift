//
//  EasySQLTut.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

//Struct is just going to be for the table
struct WesTable: SQLTable{
    
    static var columns: [Self.columnNameString : Column]{
        return["id" : Column(dataType: .INT, constraints: [.PRIMARYKEY, .NOTNULL]),
               "name" : Column(dataType: .CHAR, constraints: [.NOTNULL])]
    }
    
}

extension LoginViewController{
    
    func testWesStuff(){
        
        //Makes the file path for database //Get db file path
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "WesDatabase", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
    
        
        //Opens based on the path, if true it will create your database //Open DB
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
        do {
            
            //Create table in DB
            try db?.createTable(table: WesTable.self)
        } catch  {
            
        }
        
        //Inserting row into table
        do {
            
            //struct that makes an insert
            let insertStatement = InsertStatement(table: WesTable.self, columnValues: [1, "Wes"])
            
            try db?.insertRow(insert: insertStatement)
            
        } catch  {
    
        }
        
        //Update Statement
        do {
            
            //Builds Update Statement
            var updateStatement = UpdateStatement(table: WesTable.self, set: ["name" : "Mark"])
            
            //Appends a where where clause
            updateStatement.whereAt = ["id" : WhereStatement(clause: .NONE, columnValue: 1, expression: .EQUALS)]
            
            //Executes update statement against desired DB
            try db?.updateRow(update: updateStatement)
            
        } catch  {
            
        }
        
        
    }
    
    
}
