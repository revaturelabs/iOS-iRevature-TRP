//
//  DatabaseOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class DatabaseOperations{
    
    func openDatabse(){
        
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "iRevatureTrainer", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        //Open Databse
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
    }
    
}

struct iRevatureTables {
    
    static var userTable: SQLiteTable {
        
        var userTable = SQLiteTable(tableName: "user")
        
        //Adds columns to the instance of table 'user'
        userTable.addColumn(columnName: "user_id", dataType: .CHAR, constraints: .PRIMARYKEY, .NOTNULL)
        
        userTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
            
        userTable.addColumn(columnName: "user_role", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "token", dataType: .CHAR, constraints: nil)
        
        userTable.addColumn(columnName: "keep_logged_in", dataType: .BOOL, constraints: .none)
        
        return userTable
        
    }
    
    
    static var trainerTable: SQLiteTable {
        
        var trainerTable = SQLiteTable(tableName: "trainer")
        
        //Adds columns to the instance of table 'trainer'
        //Some contrainsts have been left blank for flexibility
        trainerTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .PRIMARYKEY, .NOTNULL)
        
        trainerTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .NOTNULL)
                
        trainerTable.addColumn(columnName: "phone_number", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "base_location", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "slack_username", dataType: .CHAR, constraints: .none)
        
        return userTable
        
    }
    
    static var batch: SQLiteTable {
        
        var batchTable = SQLiteTable(tableName: "batch")
        
        batchTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .PRIMARYKEY, .NOTNULL)
        
        batchTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .none)
        
        batchTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .none)
        
        batchTable.addColumn(columnName: "skill_id", dataType: .CHAR, constraints: .none)
        
        batchTable.addColumn(columnName: "number_of_seats", dataType: .INT, constraints: .NOTNULL)
        
        return userTable
        
    }
    
    static var calendar: SQLiteTable {
        
        var calendarTable = SQLiteTable(tableName: "calendar")
        
        calendarTable.addColumn(columnName: "calendar_id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        
        calendarTable.addColumn(columnName: "start_date", dataType: .CHAR, constraints: .NOTNULL)
        
        calendarTable.addColumn(columnName: "start_end", dataType: .CHAR, constraints: .NOTNULL)
        
        return userTable
        
    }
    
    static var skill: SQLiteTable {
        
        var skillTable = SQLiteTable(tableName: "skill")
        
        skillTable.addColumn(columnName: "skill_id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL, .UNIQUE)
        
        skillTable.addColumn(columnName: "skill_name", dataType: .CHAR, constraints: .NOTNULL)
        
        
        return userTable
        
    }
    
    
    static var batchRoom: SQLiteTable {
        
        var batchRoomTable = SQLiteTable(tableName: "batch_room")
        
        batchRoomTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .NOTNULL)
        
        
        batchRoomTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .NOTNULL)
        
        return userTable
        
    }
    
    static var batchSkill: SQLiteTable {
        
        var batchSkillTable = SQLiteTable(tableName: "batch_skill")
        
        batchSkillTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .NOTNULL)
        
        
        batchSkillTable.addColumn(columnName: "skill_id", dataType: .CHAR, constraints: .NOTNULL)
        
        return userTable
        
    }
    
    static var roomAvailability: SQLiteTable {
        
        var roomAvailabilityTable = SQLiteTable(tableName: "room_availability")
        
        roomAvailabilityTable.addColumn(columnName: "room_id", dataType: .CHAR, constraints: .NOTNULL)
        
        roomAvailabilityTable.addColumn(columnName: "calendar_id", dataType: .CHAR, constraints: .NOTNULL)
        
        return userTable
        
    }
    
    static var trainerSkill: SQLiteTable {
        
        var trainerSkillTable = SQLiteTable(tableName: "trainer_Skill")
        
        trainerSkillTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerSkillTable.addColumn(columnName: "skill_id", dataType: .CHAR, constraints: .NOTNULL)
        
        return userTable
        
    }
}
