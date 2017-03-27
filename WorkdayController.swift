//
//  WorkdayController.swift
//  tractwork
//
//  Created by manatee on 3/27/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import Foundation
import RealmSwift

class WorkdayController {
  let realm = try! Realm()
  
  //***** Crud functions for the controller *****//
  
  func getWorkdays() -> Results<Workday> {
    let workdays = realm.objects(Workday.self)
    return workdays
  }
  
  func getWorkday(workday:Workday) -> Workday {
    if let workday = realm.objects(Workday.self).first {
      return workday
    } else {
      return createWorkday()
    }
  }
  
  func createWorkday() -> Workday {
    print("Hit createWorkday function")
    let newWorkday = Workday(value: ["id": NSUUID().uuidString, "dayDate": Date()])
    //    newWorkday.id = NSUUID().uuidString
    //    newWorkday.dayDate = Date()
    try! realm.write {
      realm.add(newWorkday)
    }
    return newWorkday
  }
  
  
  func updateWorkday(workday: Workday) {
    try! realm.write {
      // placeholder if needed
    }
  }
  
  func destroyWorkday(workday: Workday) {
    try! realm.write {
      realm.delete(workday)
    }
  }
  
  func checkIfTodaysWorkdayExists() -> (workday: Workday,exists: Bool) {
    let workdays = getWorkdays()
    var workday = Workday()
    var exists = false
    for day in workdays {
      if day.dayDate.compare(.isToday) {
        workday = day
        exists = true
        break
      }
    }
    // return empty Workday and false if there is no workday for today
    return (workday, exists)
  }
}
