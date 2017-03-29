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
  var currentStatus = false
  
  // Labels
  @IBOutlet weak var workdayCountLabel: UILabel!
  @IBOutlet weak var todayLabel: UILabel!
  @IBOutlet weak var currentStatusLabel: UILabel!
  @IBOutlet weak var firstPunchLabel: UILabel!
  @IBOutlet weak var secondPunchLabel: UILabel!

  // Buttons
  @IBAction func timePunchButton(_ sender: Any) {
    let timePunch = TimePunchController()
    timePunch.createNewTimePunch(workday: todaysWorkday)
//    currentStatusLabel.text = todaysWorkday.currentStatus
    currentStatusLabel.text = todaysWorkday.getCurrentStatus()
    firstPunchLabel.text = getPunch(workday: todaysWorkday).0
    secondPunchLabel.text = getPunch(workday: todaysWorkday).1
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

    //**** Set the initial state of labels ****//
    todayLabel.text = "\(todaysWorkday.id)"
    workdayCountLabel.text = "\(workday.getWorkdays().count)"
    currentStatusLabel.text = todaysWorkday.getCurrentStatus()
    
    // Get the latest TimePunchPair and display in dashboard if exists
    // Need to push it its own function so it also can be called from button
//    if let lastPunchPair = todaysWorkday.timePunchPairs.last {
//      if let firstTimePunch = lastPunchPair.firstTimePunch {
//        print("\(firstTimePunch.punchTime.toString())")
//        firstPunchLabel.text = "\(firstTimePunch.punchTime.toString(format: .custom("hh:mm")))"
//      } else {
//        firstPunchLabel.text = "No Punches"
//      }
//      if let secondTimePunch = lastPunchPair.secondTimePunch {
//        print("\(secondTimePunch.punchTime.toString())")
//        secondPunchLabel.text = "\(secondTimePunch.punchTime.toString(format: .custom("hh:mm")))"
//      } else {
//        secondPunchLabel.text = "Working"
//      }
//    }
 


    firstPunchLabel.text = getPunch(workday: todaysWorkday).0
    secondPunchLabel.text = getPunch(workday: todaysWorkday).1
    

  }
  
  func getPunch(workday: Workday) -> (String, String) {
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


}

