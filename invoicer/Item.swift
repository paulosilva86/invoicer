//
//  Item.swift
//  invoicer
//
//  Created by Paulo Silva on 23/01/15.
//  Copyright (c) 2015 paulosilva. All rights reserved.
//

import Foundation

class Item {
  
  var name:String
  var unitPrice:Double
  var rrp:Double
  
  init(name: String, unitPrice: Double, rrp: Double) {
    self.name = name
    self.unitPrice = unitPrice
    self.rrp = rrp
  }
}
