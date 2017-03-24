//
//  FirstViewController.swift
//  tractwork
//
//  Created by Timothy Ludi on 3/23/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController {
  let realm = try! Realm()
  
  // Labels
  @IBOutlet weak var workdayCountLabel: UILabel!
  @IBOutlet weak var todayLabel: UILabel!

  // Buttons
  @IBAction func clearWorkdaysButton(_ sender: UIButton) {
    let realm = try! Realm()
    let workdays = getWorkdays()
    try! realm.write {
      realm.delete(workdays)
    }
    workdayCountLabel.text = "\(Workday().getNumberOfWorkdays())"
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let workday = getWorkday()
    if workday.dayDate.compare(.isToday) {
      todayLabel.text = "Today"
      workdayCountLabel.text = "Number of Workdays \(getWorkdays().count)"
    }
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func getWorkdays() -> Results<Workday> {
    let workdays = realm.objects(Workday.self)
    return workdays
  }
  
  func getWorkday() -> Workday {
    if let workday = realm.objects(Workday.self).first {
      return workday
    } else {
      return newWorkday()
    }
  }
  
  func newWorkday() -> Workday {
    let workday = Workday()
    return workday
  }
  
  func createWorkday(workday: Workday) {
    try! realm.write {
      realm.add(workday)
    }
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
  
  
  


}

