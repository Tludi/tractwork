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
    firstPunchLabel.text = TimePunchController().punchFromLastTimePunchPair(workday: todaysWorkday).firstPunch
    secondPunchLabel.text = TimePunchController().punchFromLastTimePunchPair(workday: todaysWorkday).secondPunch
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
 
    firstPunchLabel.text = TimePunchController().punchFromLastTimePunchPair(workday: todaysWorkday).firstPunch
    secondPunchLabel.text = TimePunchController().punchFromLastTimePunchPair(workday: todaysWorkday).secondPunch
    
  }



}

