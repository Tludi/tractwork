//
//  SecondViewController.swift
//  tractwork
//
//  Created by Timothy Ludi on 3/23/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

  override func viewWillAppear(_ animated: Bool) {
    let workdays = try! Realm().objects(Workday.self)
    if let workday = workdays.last {
      let timepunches = workday.timePunchPairs
      print("\(timepunches.count)")
      for punch in timepunches {
        print("\(punch.firstTimePunch)")
        print("\(punch.secondTimePunch)")
        print("Time Punch difference is: \(punch.punchDifference)")
        print("Workday Status is: \(workday.currentStatus)")

      }
    } else {
      print("There are no workdays")
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
//    let workdays = try! Realm().objects(Workday.self)
//    if let workday = workdays.last {
//      let timepunches = workday.timePunchPairs
//      print("\(timepunches.count)")
//      for punch in timepunches {
//        print("\(punch.firstTimePunch)")
//        print("\(punch.secondTimePunch)")
//      }
//    } else {
//      print("There are no workdays")
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
  }




}

