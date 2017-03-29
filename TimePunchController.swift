//
//  TimePunchController.swift
//  tractwork
//
//  Created by manatee on 3/27/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import Foundation
import RealmSwift

class TimePunchController {
  let realm = try! Realm()

  
  //***** TimePunch functions *****//
  func createNewTimePunch(workday: Workday) {
    print("Hit create new timepunch function")
    print("Workday ID: \(workday.id)")
    //    let timePunch = TimePunch()
    
    // Get latest timePunchPair
    var lastTimePunchPair = getLastTimePunchPair(workday: workday)
    // Check if latest timePunchPair is full (2 punches)
    if checkIfTimePunchPairIsFull(timePunchPair: lastTimePunchPair) {
      print("last timePunchPair is full, creating new TPP")
      // if latest timePunchpair is full, create new timePunchPair
      lastTimePunchPair = createNewTimePunchPair(workday: workday)
    }
    // create new timePunch and
    // if latest timePunchPair is not full, add new punch to latest TPP
    newTimePunch(workday: workday, timePunchPair: lastTimePunchPair)
    
  }
  
  func getLastTimePunchPair(workday: Workday) -> TimePunchPair {
    if let timePunchPair = workday.timePunchPairs.last {
      return timePunchPair
    } else {
      let timePunchPair = createNewTimePunchPair(workday: workday)
      return timePunchPair
    }
  }
  
  func checkIfTimePunchPairIsFull(timePunchPair: TimePunchPair) -> Bool {
    if timePunchPair.secondTimePunch == nil {
      return false
    } else {
      return true
    }
  }
  
  func createNewTimePunchPair(workday: Workday) -> TimePunchPair {
    print("Hit create new TimePunch Pair")
    let newTimePunchPair = TimePunchPair()
    try! realm.write {
      workday.timePunchPairs.append(newTimePunchPair)
    }
    return newTimePunchPair
  }
  
  
  func punchFromLastTimePunchPair(workday: Workday) -> (firstPunch:String, secondPunch:String) {
    var firstString = ""
    var secondString = ""
    if let lastPunchPair = workday.timePunchPairs.last {
      if let firstTimePunch = lastPunchPair.firstTimePunch {
        firstString = firstTimePunch.punchTime.toString(format: .custom("hh:mm"))
      } else {
        firstString = "No Punches"
      }
      if let secondTimePunch = lastPunchPair.secondTimePunch {
        secondString = secondTimePunch.punchTime.toString(format: .custom("hh:mm"))
      } else {
        secondString = "Working"
      }
    }
    return (firstString, secondString)
  }
  
  func newTimePunch(workday: Workday, timePunchPair: TimePunchPair) {
    if timePunchPair.firstTimePunch == nil {
      try! realm.write {
        timePunchPair.firstTimePunch = TimePunch(value: ["id": NSUUID().uuidString, "dayDate": Date(), "status": true])
        workday.currentStatus = true
      }
      print("created first TimePunch in a new pair")
      print("Time Punch difference is: \(timePunchPair.punchDifference)")
    } else {
      try! realm.write {
        timePunchPair.secondTimePunch = TimePunch(value: ["id": NSUUID().uuidString, "dayDate": Date(), "status": false])
        timePunchPair.punchDifference = calculateTimePunchDifference(firstTimePunch: timePunchPair.firstTimePunch!, secondTimePunch: timePunchPair.secondTimePunch!)
        workday.currentStatus = false
      }
      print("created second TimePunch")
    }
  }
  
  func calculateTimePunchDifference(firstTimePunch: TimePunch, secondTimePunch: TimePunch) -> Int {
    let difference = secondTimePunch.punchTime.since(firstTimePunch.punchTime, in: .minute)
    return Int(difference)
    
  }

}
