//
//  Workday.swift
//  tractwork
//
//  Created by Timothy Ludi on 3/23/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//
// Workday() model for TractWork. 


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
  
  let timePunchPairs = List<TimePunchPair>()
  let timePunches = List<TimePunch>()
//  let additionalTimes = List<AdditionalTime>()
//  let projects = List<Project>()
  
}

extension Workday {
  func getCurrentStatus() -> String {
    if self.currentStatus {
      return "Clocked In"
    } else {
      return "Clocked Out"
    }
  }
}


//class TimePunchPair: Object {
//  dynamic var firstTimePunch: TimePunch?
//  dynamic var secondTimePunch: TimePunch?
//}
//
//
//class TimePunch: Object {
//  dynamic var id = ""
//  dynamic var punchTime = Date()
//  dynamic var status = false
//  
//  override static func primaryKey() -> String? {
//    return "id"
//  }
//  
//  var timePunchWorkday = LinkingObjects(fromType: Workday.self, property: "timePunches")
//}


// Objects to include later

//class AdditionalTime: Object {
//  dynamic var id = ""
//  dynamic var addedTime = Int()
//  
//  override static func primaryKey() -> String? {
//    return "id"
//  }
//  
//  var additionalTimeWorkday = LinkingObjects(fromType: Workday.self, property: "additionalTimes")
//}
//
//
//class Project: Object {
//  dynamic var id = ""
//  dynamic var projectName = "general work"
//  dynamic var projectExternalID = "project ID"
//  dynamic var locationAddress = "1234 happy drive"
//  dynamic var locationCity = "Portland"
//  dynamic var locationState = "Oregon"
//  dynamic var locationZIP = "12345"
//  
//  override static func primaryKey() -> String? {
//    return "id"
//  }
//  
//  var workdayProject = LinkingObjects(fromType: Workday.self, property: "projects")
//  
//}

