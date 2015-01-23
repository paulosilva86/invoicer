//
//  ClientRepository.swift
//  invoicer
//
//  Created by Paulo Silva on 23/01/15.
//  Copyright (c) 2015 paulosilva. All rights reserved.
//

import Foundation

class ClientRepository {
  
  var clients = [
    Client(name: "Mario"),
    Client(name: "Luigi"),
    Client(name: "Princess"),
    Client(name: "Toad"),
    Client(name: "Bowser")
  ]
  
  func getClients() -> Array<Client> {
    return clients
  }
}
