//
//  WorkWeeksController.swift
//  tractwork
//
//  Created by Timothy Ludi on 4/10/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import Foundation
import RealmSwift

class WorkWeekController  {
  let realm = try! Realm()

// check on app start for first time
  // 1. Check if workweeks exist for the year
  // 2. Create workweeks for the year if they do not exist
      // for the whole year or just for passed weeks?
// check each day?
  // 3. Create current workweek if it does not exist
  
// or create all workweeks for the year on app start for first time then create again when there is a new year
  
  
  func createWorkWeeksForYear() {
    //    dynamic var id = ""
    //    dynamic var weekYear = Int()
    //    dynamic var weekNumber = Int()
    //    dynamic var startOfWeek = Date()
    //    dynamic var endOfWeek = Date()
    //    dynamic var totalWeekMinutes = Int()
    let date = Date()
    var workweeks = [WorkWeek]()
    
    // current number of the week for the year. ex. week 12
    let currentWeekNumber = date.component(.week)
    
    
    var count = date.component(.week)!
    var diff = 0
    var startsOfTheWeek: [Date] = []
    while count > 0 {
      let day = date.dateFor(.startOfWeek).adjust(.week, offset: diff)
      print(day)
      startsOfTheWeek.append(day)
      count -= 1
      diff -= 1
    }
    
  }
  
  func createCurrentWorkweek(date: Date) {
    let weekExists = checkIfCurrentWeekExists(date: date)
    if !weekExists {
      let newWeek = WorkWeek(
        value: [
          "id": NSUUID().uuidString,
          "weekYear" : date.component(.year)!,
          "weekNumber" : date.component(.month)!,
          "startOfWeek" : date.dateFor(.startOfWeek),
          "endOfWeek" : date.dateFor(.endOfWeek)
        ])
      try! realm.write {
        realm.add(newWeek)
        print("created new week")
      }
    } else {
      print("week already exists")
    }
    
  }
  
  func checkIfCurrentWeekExists(date: Date) -> Bool {
    var result = false
    let week = realm.objects(WorkWeek.self).filter("weekNumber == %@", date.component(.week)!)
    if week.count != 0 {
      result = true
    } else {
      print("workweek does not exist")
    }
    print(result)
    return result
  }
}
