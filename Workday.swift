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
  
  func getTotalTime() -> String {
    let totalMinutes = self.totalWorkdayMinutes
    let hours = totalMinutes/60
    let minutes = totalMinutes%60
    if minutes < 10 {
      return "\(hours):0\(minutes)"
    } else {
      return "\(hours):\(minutes)"
    }
  }
}



