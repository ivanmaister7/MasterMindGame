//
//  PickerDelegateAndDataSource.swift
//  MasterMindGame
//
//  Created by Master on 10.12.2022.
//

import Foundation
import UIKit

class PickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var dataSource: [Int]
    var currentValue = 0
    
    init(dataSource: [Int]) {
        self.dataSource = dataSource
        self.currentValue = dataSource.first ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(dataSource[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentValue = dataSource[row]
    }
    
}

//class ColorsPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    let colors = [4,5,6,7,8]
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        colors.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        "\(colors[row])"
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(colors[row])")
//    }
//
//}
//
//class MovesPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    let moves = [4,5,6,7,8]
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        moves.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        "\(moves[row])"
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(moves[row])")
//    }
//
//}
//
//class TimerPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    let timer = [4,5,6,7,8]
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        timer.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        "\(timer[row])"
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(timer[row])")
//    }
//
//}
