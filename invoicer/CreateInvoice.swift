//
//  CreateInvoice.swift
//  invoicer
//
//  Created by Paulo Silva on 06/03/15.
//  Copyright (c) 2015 paulosilva. All rights reserved.
//

import Foundation

class CreateInvoice {
  
  func run(date:String, client:String, item:String, unitPrice:Double) -> Bool {
    let xml = buildXml(date: date, client: client, item: item, unitPrice: unitPrice)
    let request = setupRequest(xml: xml)

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request)
    
    dataTask.resume()

    return true
  }
  
  func buildXml(date:String, client:String, item:String, unitPrice:Double) -> String {
    var xmlBody = "<invoice>"
    xmlBody    += "<date>\(date)</date>"
    xmlBody    += "<due_date>\(date)</due_date>"
    xmlBody    += "<tax_exemption>M01</tax_exemption>"
    xmlBody    += "<client>"
    xmlBody    += "<name>\(client)</name>"
    xmlBody    += "</client>"
    xmlBody    += "<items type='array'>"
    xmlBody    += "<item>"
    xmlBody    += "<name>\(item)</name>"
    xmlBody    += "<unit_price>\(unitPrice)</unit_price>"
    xmlBody    += "</item>"
    xmlBody    += "</items>"
    xmlBody    += "</invoice>"
    
    return xmlBody
  }
  
  func setupRequest(xml:String) -> URLRequest {
    let url = URL(string: "http://swat.bizflow.com:3001/invoices.xml?api_key=7e22a3112b5e92552fe1b0f48b7a0fa290b94c7a")!
    
    let bodyEncoded = xml.data(using: String.Encoding.utf8)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = bodyEncoded
    
    return request
  }
}
