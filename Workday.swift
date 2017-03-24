//
//  Workday.swift
//  tractwork
//
//  Created by Timothy Ludi on 3/23/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import UIKit
import RealmSwift

class WorkWeek: Object {
  dynamic var id = ""
  dynamic var weekYear = Int()
  dynamic var weekNumber = Int()
  dynamic var startOfWeek = Date()
  dynamic var endOfWeek = Date()
  dynamic var totalWeekMinutes = Int()
  let workdays = List<Workday>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  let dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
}

class Workday: Object {
  dynamic var id = ""
  dynamic var dayDate = Date()
  dynamic var project = "general work"
  dynamic var totalHoursWorked = "0:00"
  dynamic var totalWorkdayMinutes: Int = 0
  
  dynamic var worker = "milo"
  dynamic var currentStatus = false
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  let timePunches = List<TimePunch>()
  let additionalTimes = List<AdditionalTime>()
  let projects = List<Project>()
  
}

class TimePunchPair: Object {
  
}


class TimePunch: Object {
  dynamic var id = ""
  dynamic var punchTime = Date()
  dynamic var status = false
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var timePunchWorkday = LinkingObjects(fromType: Workday.self, property: "timePunches")
}

class AdditionalTime: Object {
  dynamic var id = ""
  dynamic var addedTime = Int()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var additionalTimeWorkday = LinkingObjects(fromType: Workday.self, property: "additionalTimes")
}


class Project: Object {
  dynamic var id = ""
  dynamic var projectName = "general work"
  dynamic var projectExternalID = "project ID"
  dynamic var locationAddress = "1234 happy drive"
  dynamic var locationCity = "Portland"
  dynamic var locationState = "Oregon"
  dynamic var locationZIP = "12345"
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var workdayProject = LinkingObjects(fromType: Workday.self, property: "projects")
  
}


extension Workday {
  func getNumberOfWorkdays() -> Int {
    let realm = try! Realm()
    let workdayCount = realm.objects(Workday.self).count
    return workdayCount
  }
  
  func retrieveTodaysWorkday() -> Workday {
    print("Hit retrieveTodaysWorkday function")
    let realm = try! Realm()
    var workday = Workday()
    let workdays = realm.objects(Workday.self)
    
    
    // check if there are any workdays
//    if workdays.count > 0 {
    
      // If there are workdays, check if there is a workday for today
      for wday in workdays {
        print("there are workdays")
        print("\(wday.dayDate) - Date")
        
        // TODO: sort workdays with newest first then break if statement when
        // One is found so app does not continue to waste
        if wday.dayDate.compare(.isToday) {
          workday = wday
          break
        }
        // Go through each workday and compare it to todays Date
        // If existing date is found, break loop and return that day to app
        // If existing date is not found, create new workday
        // Can the search start with the latest entry?
      }
      
      if workday.id == "" {
        print("id is empty")
        workday = createNewWorkday()
      }
      return workday
      
      // If there are no workdays or not a workday for today, create new workday
//    } else {
//      print("there are no workdays in the database")
//      workday = createNewWorkday()
//    }
//    return workday
  }
  
//  func checkIfWorkdayExists() -> Bool {
//    let workdays = try! Realm().objects(Workday.self)
//    for wday in workdays {
//      print("there are workdays")
//      print("\(wday.dayDate) - Date")
//      
//      // TODO: sort workdays with newest first then break if statement when
//      // One is found so app does not continue to waste
//      if wday.dayDate.compare(.isToday) {
////        workday = wday
//        return true
//        break
//      } else {
//        return false
//      }
//
//    }
//  }
  
  func createNewWorkday() -> Workday {
    // Is there a need to check if workday with todays date exists?
    // Only if calling this function without already checking
    print("Hit createNewWorkday function")
    let realm = try! Realm()
    let newWorkday = Workday()
    try! realm.write {
      newWorkday.id = NSUUID().uuidString
      newWorkday.dayDate = Date()
      realm.add(newWorkday)
    }
    return newWorkday
  }
}
