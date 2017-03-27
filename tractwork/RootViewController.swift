//
//  FirstViewController.swift
//  tractwork
//
//  Created by Timothy Ludi on 3/23/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import UIKit
import RealmSwift

class RootViewController: UIViewController {
  let realm = try! Realm()
  var todaysWorkday = Workday()
  
  // Labels
  @IBOutlet weak var workdayCountLabel: UILabel!
  @IBOutlet weak var todayLabel: UILabel!

  // Buttons
  @IBAction func timePunchButton(_ sender: Any) {
    let timePunch = TimePunchController()
    timePunch.createNewTimePunch(workday: todaysWorkday)
  }
  
  
  //**** Testing features to remove later ****//
  @IBAction func clearWorkdaysButton(_ sender: UIButton) {
    let realm = try! Realm()
    let workdays = WorkdayController().getWorkdays()
    try! realm.write {
      realm.delete(workdays)
    }
    workdayCountLabel.text = "\(WorkdayController().getWorkdays().count)"
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // MARK: -Variables
    let workday = WorkdayController()
    
    let today = workday.checkIfTodaysWorkdayExists()
    
    if today.exists {
      todayLabel.text = "Today"
      todaysWorkday = today.workday
    } else {
      todaysWorkday = workday.createWorkday()
    }
    
//    let todaysTimePunches = todaysWorkday.timePunches
    
    
    //**** Set the initial state of labels ****//
    todayLabel.text = "\(todaysWorkday.id)"
    workdayCountLabel.text = "\(workday.getWorkdays().count)"
    

  }
  

  
  
  
  
////***** Crud functions for the controller *****//
//  
//  func getWorkdays() -> Results<Workday> {
//    let workdays = realm.objects(Workday.self)
//    return workdays
//  }
//  
//  func getWorkday(workday:Workday) -> Workday {
//    if let workday = realm.objects(Workday.self).first {
//      return workday
//    } else {
//      return createWorkday()
//    }
//  }
//  
//  func createWorkday() -> Workday {
//    print("Hit createWorkday function")
//    let newWorkday = Workday(value: ["id": NSUUID().uuidString, "dayDate": Date()])
////    newWorkday.id = NSUUID().uuidString
////    newWorkday.dayDate = Date()
//    try! realm.write {
//      realm.add(newWorkday)
//    }
//    return newWorkday
//  }
//  
//  
//  func updateWorkday(workday: Workday) {
//    try! realm.write {
//      // placeholder if needed
//    }
//  }
//  
//  func destroyWorkday(workday: Workday) {
//    try! realm.write {
//      realm.delete(workday)
//    }
//  }
//  
//  func checkIfTodaysWorkdayExists() -> (workday: Workday,exists: Bool) {
//    let workdays = getWorkdays()
//    var workday = Workday()
//    var exists = false
//    for day in workdays {
//      if day.dayDate.compare(.isToday) {
//        workday = day
//        exists = true
//        break
//      }
//    }
//    // return empty Workday and false if there is no workday for today
//    return (workday, exists)
//  }
  
  
  //***** TimePunch functions *****//
//  func createNewTimePunch(workday: Workday) {
//    print("Hit create new timepunch function")
//    print("Workday ID: \(workday.id)")
////    let timePunch = TimePunch()
//    
//    // Get latest timePunchPair
//    var lastTimePunchPair = getLastTimePunchPair(workday: workday)
//    // Check if latest timePunchPair is full (2 punches)
//    if checkIfTimePunchPairIsFull(timePunchPair: lastTimePunchPair) {
//      print("last timePunchPair is full, creating new TPP")
//      // if latest timePunchpair is full, create new timePunchPair
//      lastTimePunchPair = createNewTimePunchPair(workday: workday)
//    }
//    // create new timePunch and
//    // if latest timePunchPair is not full, add new punch to latest TPP
//    newTimePunch(workday: workday, timePunchPair: lastTimePunchPair)
//    
//  }
//  
//  func getLastTimePunchPair(workday: Workday) -> TimePunchPair {
//    if let timePunchPair = workday.timePunchPairs.last {
//      return timePunchPair
//    } else {
//      let timePunchPair = createNewTimePunchPair(workday: workday)
//      return timePunchPair
//    }
//  }
//  
//  func checkIfTimePunchPairIsFull(timePunchPair: TimePunchPair) -> Bool {
//    if timePunchPair.secondTimePunch == nil {
//      return false
//    } else {
//      return true
//    }
//  }
//  
//  func createNewTimePunchPair(workday: Workday) -> TimePunchPair {
//    print("Hit create new TimePunch Pair")
//    let newTimePunchPair = TimePunchPair()
//    try! realm.write {
//      workday.timePunchPairs.append(newTimePunchPair)
//    }
//    return newTimePunchPair
//  }
//  
//  func newTimePunch(workday: Workday, timePunchPair: TimePunchPair) {
//    if timePunchPair.firstTimePunch == nil {
//      try! realm.write {
//        timePunchPair.firstTimePunch = TimePunch(value: ["id": NSUUID().uuidString, "dayDate": Date()])
//      }
//      print("created first TimePunch in a new pair")
//    } else {
//      try! realm.write {
//      timePunchPair.secondTimePunch = TimePunch(value: ["id": NSUUID().uuidString, "dayDate": Date()])
//      }
//      print("created second TimePunch")
//    }
//    
//
//  }
  


}

