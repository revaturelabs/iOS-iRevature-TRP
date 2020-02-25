//
//  EntityList.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/14/20.
//  Modified by Jeremy Malisse on 2/21/20
//  Copyright © 2020 admin. All rights reserved.
//

/// An object which represents a `Batch` associates, regardless of current, previous, or future assignment.
/// Each `Batch` has a set of `skills` that they will require and these are associated with the `Trainer` that may have the skills
/// required to teach/train them. Each `Batch` also has a primary `Location` they will be located at and must be tracked
/// for the purposes of filtering the appropriate `Location` objects in the UI Layer.
struct Batch : Codable
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
struct Trainer : Codable
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
struct Room : Codable
{
    var id : String
    var room : String
    var capacity : Int
}

/// A `Skill` object is represented by a unique ID and a name. Skills are referred to by `Batch` objects and `Trainer` objects.
struct Skill : Codable
{
    var name : String
}


/// A `Location` object which is relative to a `Campus` object.
struct Location : Codable
{
    var id : String
    var state : String
    var campus : String
    var building : String
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



//====================================================================================================//

/*
    
    API call entity parameter objects from here down.
    These entities are only used for parasing the data directly out of the JSON objects received/encoded from the
    Revature API. Each of these should then be converted into their App Entity representations in the service layer.
    This is particularly useful for checking the status code received from the server as well as the description,
    which can be used in verifications and notifications on the client side.

 */

/// An Authentication object contains an `email` and `password` field to use for the login endpoint.
/// The API will also convert the password to a base64 encoded String before sending it out. The password itself is never stored and the `Authentication` object is made `nil` after successfully receiving any response (success or failure).
struct Authentication : Encodable
{
    var email : String
    var password : String
}

/// APIUserCall object which contains all information regarding a response from the user endpoint of the RevatureAPI.
/// `primarylocation` refers to the current user's primary site.
/// `loginToken` is the access token which needs to be stored in the User Defaults if the User
///     wishes to stay logged in. (Otherwise, held in the application until such time as it expires and needs
///     to be re-authenticated - or the app is closed.
struct APIUserCall : Codable
{
  let primaryLocation : String
  let statusCode : Int
  let description : String
  let loginToken : String
  let currentSystemRole : SystemRole
}

/// APIUserCall object which contains all information regarding a response from the location endpoint of the RevatureAPI.
/// `alllocation` is the variable which needs to be parsed for the list of `Location` objects
struct APILocationCall : Codable
{
    var statusCode : Int
    var description : String
    var alllocation : [APILocation]
}

/// A `Location` object for the API call that does not keep the `Campus` as a campus object, but rather a string.
/// Once parsed this will need to be  converted to a `Location` object that contains a reference
/// to a `Campus` object.
struct APILocation : Codable
{
    var id : String
    var state : String
    var campus : String
    var building : String
}




/// APIUserCall object which contains all information regarding a response from the trainer endpoint of the RevatureAPI.
/// `trainers` is the variable which needs to be parsed for the list of `Trainer` objects
struct APITrainerCall : Codable
{
    var statusCode : Int
    var description : String
    var trainers : [Trainer]
}

/// APIUserCall object which contains all information regarding a response from the room endpoint of the RevatureAPI.
/// `allrooms` is the variable which needs to be parsed for the list of `Room` objects
/// `allcampus` is the variable which needs to be parsed for the list of `Campus` objects
struct APIRoomCall : Codable
{
    var statusCode : Int
    var description : String
    var allcampus : [APICampus]
    var allrooms : [Room]
}

/// APIUserCall object which contains all information regarding a response from the room endpoint of the RevatureAPI.
/// `id` is a vestigial parameter that is necessary for conforming to the Encoded type from the API response, but is otherwise unused.
/// `campus` is the actual reference String that represents the `Campus` data for the `APIRoomCall`
struct APICampus : Codable
{
    var id : String
    var campus : String
}

/// APIUserCall object which contains all information regarding a response from the skills endpoint of the RevatureAPI.
/// `skills` is the variable which needs to be parsed for the list of `APISkill` objects
#warning("These objets are in contract with previously discussed and developed entity objects for the persistence layer. Possible refactor of entity/persistence mmodel required.")
struct APISkillCall : Codable
{
    var statusCode : Int
    var description : String
    var skills : [APISkill]
}

struct APISkill : Codable
{
    var id : String
    var name : String
    var score : String
}

/// APIUserCall object which contains all information regarding a response from the trainer endpoint of the RevatureAPI.
/// `batchInfo` is the variable which needs to be parsed for the list of `APIBatch` objects
#warning("These objets are in contract with previously discussed and developed entity objects for the persistence layer. Possible refactor of entity/persistence mmodel required.")
struct APIBatchCall : Codable
{
    var statusCode : Int
    var description : String
    var batchInfo : [APIBatch]
}

struct APIBatch : Codable
{
    var id : String
    var name : String
    var startDate : String
    var endDate : String
    var createdById : String
    var modifiedById : String
    var inchargeId : String
}



