//
//  EntityList.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/14/20.
//  Modified by Jeremy Malisse on 2/21/20
//  Copyright © 2020 admin. All rights reserved.
//


/// An Authentication object contains an `email` and `password` field to use for the login endpoint.
/// The API will also convert the password to a base64 encoded String before sending it out. The password itself is never stored and the `Authentication` object is destroyed after successfully receiving any response (success or failure).
struct Authentication : Encodable
{
    var email : String
    var password : String
}


/// An object which represents a `Batch` associates, regardless of current, previous, or future assignment.
/// Each `Batch` has a set of `skills` that they will require and these are associated with the `Trainer` that may have the skills
/// required to teach/train them. Each `Batch` also has a primary `Location` they will be located at and must be tracked
/// for the purposes of filtering the appropriate `Location` objects in the UI Layer.
struct Batch
{
    var name : String
    var size : Int
    var skills : [Skill]
    var location : Location
}

/// The main `User` object of the application which stores all relative access information for both the API and Application level functions.
/// The most important information for API access is held in the `token` parameter. If the `token` has been deauthenticated (expired)
/// the system should aim to update/refresh the token. Application level functions should be limited to the `currentRole`
struct User : Codable
{
    var firstName : String?
    var lastName : String?
    var primaryLocation : String
    var email : String
    var keepLoggedIn : Bool
    var loginToken : String
    var currentRole : SystemRole
}

/// Lower level authentication object which is returned from the Revature API
/// Contains all information about whether an authentication was successful and which codes were returned.
/// The most important aspect is the `loginToken` which is the authentication token that must be stored internally and used
/// for all further calls during the application lifecycle.
/// Additionally, Users may opt to "Stay Logged In", in which case the token may eventually be de-authenticated and refreshed.
struct CurrentUser : Codable
{
  let primaryLocation : String
  let statusCode : Int
  let description : String
  let loginToken : String
  let currentSystemRole : SystemRole
}

/// Upper level authentication object which contains more broad information about a User's current access level to the application functions.
/// Operations should be based on the `code` stored in the object. Each `User` object will store their own `SystemRole`
struct SystemRole : Codable
{
  let id : Int
  let code : String
  let description : String
  let name: String
}

/// `Trainer` object which represents an individual employed by Revature in the trainer position.
/// Each trainer has a unique ID, a name, an email, a location, and a set of skills.
/// They may have a picture file stored somewhere on the server. A possible future inclusion would be to add their stored profile picture
/// to the local cache to use in the trainer workflow, but at this time the functionality is not universally supported within the API/Revature.
struct Trainer
{
    var id : Int
    var name : String
    var email : String
    var location : Location
    var picture : String?
    var skills : [Skill]
}

/// A `Room` object which is the main focus of the current implementation. `Batch` objects and `Trainer` objects are
/// associated to specific rooms during the Room Planning/Request cycle for specific date ranges.
/// For persistence refer to the `Availability` object which will refer the start and end date of each `Room` booking.
struct Room
{
    var id : String
    var room : String
    var capacity : Int
}

/// A `Skill` object is represented by a unique ID and a name. Skills are referred to by `Batch` objects and `Trainer` objects.
struct Skill
{
    var id : Int
    var name : String
}

/// The `Campus` object is part of the set of objects which represent a part of each overall location. This is different from a `Location` object in that it only refers
/// to the name of the `Campus` and a unique ID for persistence.
struct Campus
{
    var id : String
    var campus : String
}

/// A `Location` object which is relative to a `Campus` object.
struct Location : Codable
{
    var id : String
    var state : String
    var campus : String
    var building : String
}


/*
 "statusCode": 200,
 "description": "Authentication successful",
 "alllocation": [
   {
     "id": "LOC001",
     "state": "FL",
     "campus": "UTA",
     "building": "Other"
 */

/// A `Location` object which is relative to a `Campus` object.
struct APILocationCall : Codable
{
    var statusCode : Int
    var description : String
    var alllocation : [Location]
}

/// A `Calendar` object which represents a start and end date for each room booking. This is intrinsicly tied to an `Availability` object as every
/// single `Calendar` object must be associated with a `Room` that has that date range requested/planned/assigned.
struct Calendar
{
    var id : Int
    var startDate : String
    var endDate : String
}

/// The `Availability` object is important as each `Room` can be booked for multiple time periods and each time period
/// must be individually tracked and correlated for further requests.
/// The `calendars` refers to a list of `Calendar` objects - each one representing a start and end date of a previously assigned request which
/// may or may not have already occurred.
struct Availability
{
    var roomId : Int
    var calendars : [Calendar]
}

/// A class which manages the final planning request requirements and operations.
/// Each of the three main parameters, `batch`, `trainer`, and `room` are required before a request can be sent to the endpoint.
/// These selections are made through the Application operations and are directly tied to the data in the persistence
/// method which is data stored from the overall Revature API.
// TODO: update as necessary changes are added
class RoomCompletion
{
    var batch : Batch?
    var trainer : Trainer?
    var room : Room?
}
