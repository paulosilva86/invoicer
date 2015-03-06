//
//  ViewController.swift
//  invoicer
//
//  Created by Paulo Silva on 23/01/15.
//  Copyright (c) 2015 paulosilva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  var clientRepository = ClientRepository()
  var itemRepository = ItemRepository()
  var interactor = CreateInvoice()
  
  @IBOutlet var date: UITextField!
  @IBOutlet var client: UITextField!
  @IBOutlet var item: UITextField!
  @IBOutlet var clientPicker: UIPickerView!
  @IBOutlet var itemPicker: UIPickerView!
  
  @IBOutlet weak var itemSumLabel: UILabel!
  @IBOutlet weak var itemVatLabel: UILabel!
  @IBOutlet weak var itemTotalLabel: UILabel!
  
  @IBOutlet weak var createInvoiceButton: UIButton!
  
  @IBAction func createInvoice(sender: UIButton) {
    var _date = date.text
    var _client = client.text
    var _item = item.text
    var _unitPrice = itemRepository.getItemPrice(item.text!)
    
    var result = interactor.run(_date, client: _client, item: _item, unitPrice: _unitPrice)
    
    if (result) {
      println("Invoice created successfully")
    } else {
      println("Error creating invoice")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setDefaultDate()
    setClientPicker()
    setItemPicker()
  }
  
  func setDefaultDate() {
    let dateObject = NSDate()
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    date.text = dateFormatter.stringFromDate(dateObject)
  }
  
  func setClientPicker() {
    clientPicker = UIPickerView()
    clientPicker.dataSource = self
    clientPicker.delegate = self
    client.inputView = clientPicker
  }
  
  func setItemPicker() {
    itemPicker = UIPickerView()
    itemPicker.dataSource = self
    itemPicker.delegate = self
    item.inputView = itemPicker
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    self.view.endEditing(true)
  }
  
  /*
  ** UIPickerViewDataSource
  */
  
  // Returns the number of 'columns' to display.
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  // Returns the # of rows in each component..
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.isEqual(clientPicker) {
      return clientRepository.clients.count
    }
    else {
      return itemRepository.items.count
    }
  }
  
  /*
  ** UIPickerViewDelegate
  */
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    if pickerView.isEqual(clientPicker) {
      return clientRepository.clients[row].name
    }
    else {
      return itemRepository.items[row].name
    }
  }
  
  func formatCurrencyValue(value:Double) -> String {
    return String(format:"€%.2f", value)
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView.isEqual(clientPicker) {
      client.text = clientRepository.clients[row].name
    }
    else {
      var selectedItem = itemRepository.items[row]
      
      item.text = selectedItem.name
      itemSumLabel.text = formatCurrencyValue( selectedItem.unitPrice)
      itemVatLabel.text = formatCurrencyValue(selectedItem.rrp - selectedItem.unitPrice)
      itemTotalLabel.text = formatCurrencyValue(selectedItem.rrp)
      
    }
  }
}
