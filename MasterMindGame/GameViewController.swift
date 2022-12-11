//
//  GameViewController.swift
//  MasterMindGame
//
//  Created by Master on 08.12.2022.
//

import UIKit
import MasterMindEngine

class GameViewController: UIViewController {

    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var colorPicker: UIPickerView!
    @IBOutlet private weak var movesTable: UITableView!
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private weak var rollforwardButton: UIButton!
    @IBOutlet private weak var rollbackButton: UIButton!
    
    
    var gameEngine = MasterMindEngine()
    var timer = Timer()
    
    var pickerData: [[UIColor]] = [[]]
    var requestData: [RowRequest] = []
    var responceData: [RowResponce] = []
    var selectedItems: [ItemRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
        colorPicker.dataSource = self
        
        movesTable.dataSource = self

        pickerData = Array(repeating: gameEngine.getAvailableMoves(), count: gameEngine.getCurrentGameSettings().getRowSize())
        
        selectedItems = Array(repeating: ItemRequest(color: .blue), count: gameEngine.getCurrentGameSettings().getRowSize())
        
        hideRollButtons()
        timerTask()
        reloadData()
        
    }
    
    func hideRollButtons() {
        rollbackButton.isHidden = !gameEngine.getCurrentGameSettings().realtimeMode
        rollforwardButton.isHidden = !gameEngine.getCurrentGameSettings().realtimeMode
    }
    
    func timerTask() {
        self.timer.invalidate()
        timer = .scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let (isWinner, winner) = self.gameEngine.hasWinner()
            if isWinner {
                self.timer.invalidate()
                let alert = UIAlertController(title: "\(winner!.rawValue) win!",
                                              message: "Game over. You restart the game or go to the main menu and start with new settings",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                              style: .default,
                                              handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                self.rollbackButton.isHidden = false
                self.rollforwardButton.isHidden = false
                
            } else {
                let allSecondsLeft = Int(self.gameEngine.getPlayerState().allTimeLeft)
                let minutes = allSecondsLeft / 60
                let seconds = allSecondsLeft % 60
                let min = minutes < 10 ? "0\(minutes)" : "\(minutes)"
                let sec = seconds < 10 ? "0\(seconds)" : "\(seconds)"
                self.timerLabel.text = "\(min):\(sec)"
            }
        }
    }
    
    func reloadData() {
        requestData = gameEngine.getCurrentGameState().requestRows
        responceData = gameEngine.getCurrentGameState().responceRows
        
        movesTable.reloadData()
    }
    
    @IBAction func acceptMove(_ sender: Any) {
        gameEngine.nextMove(for: RowRequest(items: selectedItems))
        reloadData()
    }
    
    @IBAction func restartAction(_ sender: Any) {
        gameEngine.resignGame()
        hideRollButtons()
        timerTask()
        reloadData()
    }
    
    @IBAction func rollforwardAction(_ sender: Any) {
        gameEngine.rollForwardMove()
        reloadData()
    }
    
    @IBAction func rollbackAction(_ sender: Any) {
        gameEngine.rollbackMove()
        reloadData()
    }
    
    
}

extension GameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { "" }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.backgroundColor = pickerData[component][row]
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItems.insert(ItemRequest(color: pickerData[component][row]), at: component)
        selectedItems.remove(at: component + 1)
    }
}

extension GameViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath) as! MoveCell
        cell.confView(requestRow: requestData[indexPath.row] ,
                      responceRow: responceData[indexPath.row],
                      movesLeft: indexPath.row + 1)
        return cell
    }
    
    
}
