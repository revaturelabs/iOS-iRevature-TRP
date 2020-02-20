//
//  UserQueries.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


//struct UserTable: SQLTable{
//
//    static var columns: [Self.columnNameString : Column]{
//        return["user_id" : Column(dataType: .INT, constraints: .none)]
//    }
//
//}

extension DatabaseOperations{
    
    func createUserTable(database: DatabaseAccess){
        
        //Creates an instance of a table 'user'
        
        //Builds 'user' table and its columns into a SQLite3 Statment
        
        
        if let userTable = iRevatureTables.userTable.makeStatement(){
            debugPrint(userTable)
        }
        
        //Execute the SQLite3 prepared statement
        do {
            try database.createTable(table: iRevatureTables.userTable.self)
        } catch  {
            
            debugPrint(database)
        }
        
    }
    
    func insertUserRecord(databse: DatabaseAccess, userID: Int, firstName: String, lastName: String, email: String, token: String, keepMeLoggedIn: Bool, roles: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.userTable, columnValues: userID, firstName, lastName, email, token, true, "tester")
        
        if let insertStatement = insertStatement.makeStatement(){
            
            debugPrint(insertStatement)
        }
        
        do {
            
            try databse.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Oops!!!!!")
            
        }
        
    }
}
