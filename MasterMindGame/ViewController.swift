//
//  ViewController.swift
//  MasterMindGame
//
//  Created by Master on 24.11.2022.
//

import UIKit
import MasterMindEngine

class ViewController: UIViewController {
    
    @IBOutlet weak var rowSizeField: UITextField!
    @IBOutlet weak var colorsField: UITextField!
    @IBOutlet weak var movesField: UITextField!
    @IBOutlet weak var timerField: UITextField!
    @IBOutlet weak var realTimeModeSwitch: UISwitch!
    
    var rowSizePicker = UIPickerView()
    var colorsPicker = UIPickerView()
    var movesPicker = UIPickerView()
    var timerPicker = UIPickerView()
    
    let rowSizePickerDelegateAndDataSource = PickerDelegate(dataSource: [4,5,6,7,8])
    let colorsPickerDelegateAndDataSource = PickerDelegate(dataSource: [4,5,6,7,8])
    let movesPickerDelegateAndDataSource = PickerDelegate(dataSource: [5,6,7,8,9,10,11,12,13,14,15])
    let timerPickerDelegateAndDataSource = PickerDelegate(dataSource: [5,10,15,20,30])
    
    var rowSizeCurrentValue = 0
    var colorsCurrentValue = 0
    var movesCurrentValue = 0
    var timerCurrentValue = 0
    var realTimeMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveCurrentValues()
        setCurrentValues()
        
        configure(field: rowSizeField, picker: rowSizePicker, delegate: rowSizePickerDelegateAndDataSource, dataSource: rowSizePickerDelegateAndDataSource)
        configure(field: colorsField, picker: colorsPicker, delegate: colorsPickerDelegateAndDataSource, dataSource: colorsPickerDelegateAndDataSource)
        configure(field: movesField, picker: movesPicker, delegate: movesPickerDelegateAndDataSource, dataSource: movesPickerDelegateAndDataSource)
        configure(field: timerField, picker: timerPicker, delegate: timerPickerDelegateAndDataSource, dataSource: timerPickerDelegateAndDataSource)
        
        realTimeModeSwitch.addTarget(self, action: #selector(onChanged), for: UIControl.Event.valueChanged)
    }
    
    func configure(field: UITextField, picker: UIPickerView, delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelAction))
        
        toolBar.setItems([cancelButton, flexSpace,doneButton], animated: true)
        
        picker.delegate = delegate
        picker.dataSource = dataSource
        field.inputView = picker
        field.inputAccessoryView = toolBar
        
    }
    
    func receiveCurrentValues() {
        rowSizeCurrentValue = rowSizePickerDelegateAndDataSource.currentValue
        colorsCurrentValue = colorsPickerDelegateAndDataSource.currentValue
        movesCurrentValue = movesPickerDelegateAndDataSource.currentValue
        timerCurrentValue = timerPickerDelegateAndDataSource.currentValue
    }
    
    func setCurrentValues() {
        rowSizeField.text = "\(rowSizeCurrentValue)"
        colorsField.text = "\(colorsCurrentValue)"
        movesField.text = "\(movesCurrentValue)"
        timerField.text = "\(timerCurrentValue)"
    }
    
    @objc func onChanged(myswitch: UISwitch) {
        realTimeMode = myswitch.isOn
    }
    
    @objc func doneAction() {
        receiveCurrentValues()
        setCurrentValues()
        self.view.endEditing(true)
    }
    
    @objc func cancelAction() {
        self.view.endEditing(true)
    }
    
    @IBAction func butTap(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = (segue.destination as? GameViewController)
        destination?.gameEngine = MasterMindEngine(rowSize: rowSizeCurrentValue, moves: movesCurrentValue, colors: colorsCurrentValue, duration: Double(timerCurrentValue))
    }
}

