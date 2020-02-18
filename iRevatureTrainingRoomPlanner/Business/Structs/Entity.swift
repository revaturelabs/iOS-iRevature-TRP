//
//  EntityList.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/14/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Batch
{
    var name : String
    var size : Int
    var skills : [Skill]
    var location : Location
}

struct User : Codable
{
    var firstName : String
    var lastName : String
    var email : String
    var password : String
    var token : String
    var keepLoggedIn : Bool
    var role : Role
}

struct Trainer
{
    var id : Int
    var firstName : String
    var lastName : String
    var email : String
    var location : Location
    var skills : [Skill]
}

struct Room
{
    var name : String
    var location : Location
    var maxSeats : Int
    var roomId : Int
}

struct Skill
{
    var id : Int
    var name : String
}

struct Location
{
    var id : Int
    var city : String
    var state : String
    var building : String
}

struct Calendar
{
    var id : Int
    var startDate : Date
    var endDate : Date
}

struct Availability
{
    var roomId : Int
    var calendars : [Calendar]
}

enum Role
{
    case TrainingDirector (String)
    case SiteManager (String)
    case Administrator (String)
}

class RoomCompletion
{
    var batch : Batch?
    var trainer : Trainer?
    var room : Room?
}
