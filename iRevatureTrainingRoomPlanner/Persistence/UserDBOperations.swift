//
//  UserDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createUserTable(){
        
        //Grabs a new instance of usertables based on iRevatureTables struct
        if let userTable = iRevatureTables.userTable.makeStatement(){
            debugPrint(userTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.userTable.self)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: usertable")
            
        }
        
    }
    
    func insertUserRecord(userID: String, firstName: String, lastName: String, email: String, token: String, userRole: String, keepMeLoggedIn: Bool){
        
        let insertStatement = InsertStatement(table: iRevatureTables.userTable, columnValues: userID, firstName, lastName, email, token, userRole, keepMeLoggedIn)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    func selectUserRecord() -> [[String: Any]]{
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "first_name", asName: "First_Name")
        
        //selectStatement.getAllColumns(fromTable: iRevatureTables.userTable)
        
        do{
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
    
    func deleteUserRecord(){
        
        var deleteStatement = DeleteStatement(table: iRevatureTables.userTable)
        
        var whereStatement = WhereStatement()
        
        whereStatement.addStatement(table: iRevatureTables.userTable, columnName: "user_id", expression: .EQUALS, columnValue: "RevID_01")
        
        deleteStatement.setWhereStatement(statement: whereStatement)
        
        do{
            try database.deleteRow(statement: deleteStatement)
            debugPrint("Delete Successful")
        } catch {
            debugPrint("Opps! Delete not successful")
        }
    }
    
    func updateUserRecord(){
        
        var  updateStatement = UpdateStatement(table: iRevatureTables.userTable)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: iRevatureTables.userTable, columnName: "user_id", expression: .EQUALS, columnValue: "RevID_01")
        
        updateStatement.addValueChange(columnToUpdate: "first_name", updatedValue: "Wes")
        
        updateStatement.setWhereStatement(statement: whereStatement)
        
        do{
            
            try database.updateRow(statement: updateStatement)
            
        } catch{
            
        }
        
    }
}
