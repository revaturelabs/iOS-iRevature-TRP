//
//  DatabaseOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class DatabaseOperations{
    
    var database: DatabaseAccess
    
    init() {
        
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "iRevatureTrainer", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        //Open Databse
        self.database = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)!
        
    }
    
    func createAllTables(){
        
        //        createUserTable()
        
        createTrainerTable()
        
//        createBatchTable()
        
        createCalendarTable()
        
//        createBatchRoomTable()
//
//        createBatchSkillTable()
        
        createTrainerSkillTable()
        
//        createRoomAvailabilityTable()
        
        createRoomTable()
        
        createLocationTable()
        
    }
    
    //Shared with all other entities
    func updateRecord(column: String, value: String,whereColumn: String, whereValue: String, selectedTable: SQLiteTable){
        
        var  updateStatement = UpdateStatement(table: iRevatureTables.userTable)
        
        var whereStatement = WhereStatement()
        
        whereStatement.addStatement(table: selectedTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
        
        updateStatement.addValueChange(columnToUpdate: column, updatedValue: value)
        
        updateStatement.setWhereStatement(statement: whereStatement)
        
        do{
            
            try database.updateRow(statement: updateStatement)
            
        } catch {
            
        }
        
    }
    
    //Shared with all other entities
    func deleteRecord(whereColumn: String, whereValue: String, selectedTable: SQLiteTable){
        
        var deleteStatement = DeleteStatement(table: selectedTable)
        
        var whereStatement = WhereStatement()
        
        whereStatement.addStatement(table: selectedTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
        
        deleteStatement.setWhereStatement(statement: whereStatement)
        
        do{
            
            try database.deleteRow(statement: deleteStatement)
            
            //            debugPrint("Delete Successful")
            
        } catch {
            
            debugPrint("Opps! Delete not successful")
            
        }
    }
    

}

struct iRevatureTables {
    
    static var userTable: SQLiteTable {
        
        var userTable = SQLiteTable(tableName: "user")
        
        //Adds columns to the instance of table 'user'
        userTable.addColumn(columnName: "user_id", dataType: .CHAR, constraints: .PRIMARYKEY)
        
        userTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .none)
        
        userTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .none)
        
        userTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .none, .UNIQUE)
        
        userTable.addColumn(columnName: "user_role", dataType: .CHAR, constraints: .none)
        
        userTable.addColumn(columnName: "token", dataType: .CHAR, constraints: nil)
        
        userTable.addColumn(columnName: "keep_logged_in", dataType: .BOOL, constraints: .none)
        
        return userTable
        
    }
    
    
    static var trainerTable: SQLiteTable {
        
        var trainerTable = SQLiteTable(tableName: "trainer")
        
        //Adds columns to the instance of table 'trainer'
        //Some contrainsts have been left blank for flexibility
        trainerTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .PRIMARYKEY)
        
        trainerTable.addColumn(columnName: "full_name", dataType: .CHAR, constraints: .none)
        
        trainerTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .none)
        
        trainerTable.addColumn(columnName: "base_location", dataType: .CHAR, constraints: .none)
        
        trainerTable.addColumn(columnName: "profile_picture", dataType: .CHAR, constraints: .none)
        
        return trainerTable
        
    }
    
    static var batchTable: SQLiteTable {
        
        var batchTable = SQLiteTable(tableName: "batch")
        
        batchTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .PRIMARYKEY)
        
        batchTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .none)
        
        batchTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .none)
        
        batchTable.addColumn(columnName: "number_of_assosiates", dataType: .INT, constraints: .none)
        
        return batchTable
        
    }
    
    static var locationTable: SQLiteTable {
        
        var locationTable = SQLiteTable(tableName: "location")
        
        locationTable.addColumn(columnName: "location_id", dataType: .CHAR, constraints: .PRIMARYKEY)
        
        locationTable.addColumn(columnName: "campus", dataType: .CHAR, constraints: .none)
        
        locationTable.addColumn(columnName: "building", dataType: .CHAR, constraints: .none)
        
        locationTable.addColumn(columnName: "state", dataType: .CHAR, constraints: .none)
        
        return locationTable
        
    }
    
    static var roomTable: SQLiteTable {
        
        var batchTable = SQLiteTable(tableName: "room")
        
        batchTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .PRIMARYKEY)
        
        batchTable.addColumn(columnName: "room_name", dataType: .CHAR, constraints: .none)
        
        batchTable.addColumn(columnName: "number_of_seats", dataType: .INT, constraints: .none)
        
        return batchTable
        
    }
    
    static var calendarTable: SQLiteTable {
        
        var calendarTable = SQLiteTable(tableName: "calendar")
        
        calendarTable.addColumn(columnName: "calendar_id", dataType: .INT, constraints: .PRIMARYKEY)
        
        calendarTable.addColumn(columnName: "start_date", dataType: .CHAR, constraints: .none)
        
        calendarTable.addColumn(columnName: "end_date", dataType: .CHAR, constraints: .none)
        
        return calendarTable
        
    }
    
    static var skillTable: SQLiteTable {
        
        var skillTable = SQLiteTable(tableName: "skill")
        
        skillTable.addColumn(columnName: "skill_id", dataType: .INT, constraints: .PRIMARYKEY)
        
        skillTable.addColumn(columnName: "skill_name", dataType: .CHAR, constraints: .none)
        
        return skillTable
        
    }
    
    
    static var batchRoomTable: SQLiteTable {
        
        var batchRoomTable = SQLiteTable(tableName: "batch_room")
        
        batchRoomTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .none)
        
        
        batchRoomTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .none)
        
        return batchRoomTable
        
    }
    
    static var batchSkillTable: SQLiteTable {
        
        var batchSkillTable = SQLiteTable(tableName: "batch_skill")
        
        batchSkillTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .none)
        
        
        batchSkillTable.addColumn(columnName: "skill_id", dataType: .CHAR, constraints: .none)
        
        return batchSkillTable
        
    }
    
    static var roomAvailabilityTable: SQLiteTable {
        
        var roomAvailabilityTable = SQLiteTable(tableName: "room_availability")
        
        roomAvailabilityTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .none
        )
        
        roomAvailabilityTable.addColumn(columnName: "calendar_id", dataType: .CHAR, constraints: .none)
        
        return roomAvailabilityTable
        
    }
    
    static var trainerSkillTable: SQLiteTable {
        
        var trainerSkillTable = SQLiteTable(tableName: "trainer_Skill")
        
        trainerSkillTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .none)
        
        trainerSkillTable.addColumn(columnName: "skill_id", dataType: .CHAR, constraints: .none)
        
        return trainerSkillTable
        
    }
}
