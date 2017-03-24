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
  
  @IBOutlet weak var workdayCountLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let workday = Workday().retrieveTodaysWorkday()
    
    workdayCountLabel.text = "Number of Workdays \(Workday().getNumberOfWorkdays())"
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

