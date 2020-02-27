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
//            debugPrint(userTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.userTable.self)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: usertable")
            
        }
        
    }
    
    func insertUserRecord(userID: String, firstName: String, lastName: String, email: String, token: String, userRole: String, keepMeLoggedIn: Bool){
        
        let insertStatement = InsertStatement(table: iRevatureTables.userTable, columnValues: userID, firstName, lastName, email, userRole, token, keepMeLoggedIn)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllUserRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "user_id", asName: "userID")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "first_name", asName: "firstName")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "last_name", asName: "last_name")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "email", asName: "email")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "user_role", asName: "userRole")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "token", asName: "token")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "keep_logged_in", asName: "keepMeLoggedIn")
        
        do{
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
    
//    func deleteUserRecord(whereColumn: String, whereValue: String){
//
//        var deleteStatement = DeleteStatement(table: iRevatureTables.userTable)
//
//        var whereStatement = WhereStatement()
//
//        whereStatement.addStatement(table: iRevatureTables.userTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
//
//        deleteStatement.setWhereStatement(statement: whereStatement)
//
//        do{
//
//            try database.deleteRow(statement: deleteStatement)
//
//            debugPrint("Delete Successful")
//
//        } catch {
//
//            debugPrint("Opps! Delete not successful")
//
//        }
//    }
    
//    func updateUserRecord(column: String, value: String,whereColumn: String, whereValue: String){
//        
//        var  updateStatement = UpdateStatement(table: iRevatureTables.userTable)
//        
//        var whereStatement = WhereStatement()
//        
//        whereStatement.addStatement(table: iRevatureTables.userTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
//        
//        updateStatement.addValueChange(columnToUpdate: column, updatedValue: value)
//        
//        updateStatement.setWhereStatement(statement: whereStatement)
//        
//        do{
//            
//            try database.updateRow(statement: updateStatement)
//            
//        } catch {
//            
//        }
//        
//    }
    
}
