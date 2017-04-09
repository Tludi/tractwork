//
//  SecondViewController.swift
//  tractwork
//
//  Created by Timothy Ludi on 3/23/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import UIKit
import RealmSwift

class WorkdaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let realm = try! Realm()
  let today = Date()
  
  @IBOutlet weak var weeksTable: UITableView!
  
  override func viewWillAppear(_ animated: Bool) {
    let workdays = try! Realm().objects(Workday.self)
    if let workday = workdays.last {
      let timepunches = workday.timePunchPairs
      print("\(timepunches.count)")
      for punch in timepunches {
        print("\(String(describing: punch.firstTimePunch))")
        print("\(String(describing: punch.secondTimePunch))")
        print("Time Punch difference is: \(punch.punchDifference)")
        print("Workday Status is: \(workday.currentStatus)")

      }
    } else {
      print("There are no workdays")
    }
    weeksTable.reloadData()
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
//    return the number of weeks
    return today.component(.week)!
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var headerText = String()
    if section == 0 {
      headerText = "This Week"
    } else {
      headerText = "Week \(section)"
    }
    return headerText
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let days = realm.objects(Workday.self)
    var day = Workday()
    if days.count != 0 {
      day = days.last!
    }
      print("there are \(days.count) days")
      print("there are \(day.timePunchPairs.count) punches")
    
    return day.timePunchPairs.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let days = realm.objects(Workday.self)
    var day = Workday()
    print("there are \(days.count) days")
    if days.count != 0 {
      day = days.last!
      print(day)
    } else {
      print("there are no days")
    }
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
//    cell.textLabel?.text = "hello"
    cell.textLabel?.text = "\(String(describing: day.timePunchPairs[indexPath.row].firstTimePunch!.punchTime))"
    cell.detailTextLabel?.text = "\(String(describing: day.timePunchPairs[indexPath.row].secondTimePunch?.punchTime))"
    return cell
  }




}

