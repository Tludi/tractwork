//
//  TImePunch.swift
//  tractwork
//
//  Created by manatee on 3/27/17.
//  Copyright © 2017 Timothy Ludi. All rights reserved.
//

import Foundation
import RealmSwift

class TimePunchPair: Object {
  dynamic var firstTimePunch: TimePunch?
  dynamic var secondTimePunch: TimePunch?
  dynamic var punchDifference: Int = 0
}


class TimePunch: Object {
  dynamic var id = ""
  dynamic var punchTime = Date()
  dynamic var status = false
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var timePunchWorkday = LinkingObjects(fromType: Workday.self, property: "timePunches")
}
