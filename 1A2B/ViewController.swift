//
//  ViewController.swift
//  1A2B
//
//  Created by HanYuan on 2022/11/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var inputLabels: [UILabel]!
    @IBOutlet var inputButtons: [UIButton]!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    
    var answerNumbers  = [Int]()
    var answerNumber = Int()
    var inputNumbers = [Int]()
    var index = -1
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replay()
    }
    
    @IBAction func inputButton(_ sender: UIButton) {
        if index < 3 {
            index += 1
            inputLabels[index].text = String(sender.tag)
            sender.isEnabled = false
            inputNumbers.append(sender.tag)
            alertLabel.text = ""
        }
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        sender.isEnabled  = false
        replay()
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        if inputNumbers != [Int]() {
            inputNumbers.removeLast()
            inputButtons[Int((inputLabels[index].text!))!].isEnabled = true
            inputLabels[index].text = ""
            index -= 1
        }
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        var aCount = 0
        var bCount = 0
        
        if inputNumbers.count < 4 {
            alertLabel.text = "輸入錯誤"
            reset()
        } else {
            var numberString = String()
            for i in inputNumbers {
                numberString += String(i)
            }
            for i in 0...3 {
                if inputNumbers[i] == answerNumbers[i] {
                    aCount += 1
                } else if answerNumbers.contains(inputNumbers[i]) {
                    bCount += 1
                }
            }
            resultTextView.text += "\(numberString)   \(aCount)A\(bCount)B\n"
            sum += 1
            reset()
        }
        
        if aCount == 4 {
            gameOver()
            sender.isEnabled = false
        }
        
    }
    
    func replay() {
        answerNumbers = [Int]()
        resultTextView.text = ""
        sum = 0
        for _ in 0...3 {
            answerNumber = Int.random(in: 0...9)
            while answerNumbers.contains(answerNumber) {
                answerNumber = Int.random(in: 0...9)
            }
            answerNumbers.append(answerNumber)
        }
        reset()
        deleteButton.isEnabled = true
        doneButton.isEnabled = true
        print(answerNumbers)
    }
    
    func reset() {
        index = -1
        inputNumbers = [Int]()
        for label in inputLabels {
            label.text = ""
        }
        for button in inputButtons {
            button.isEnabled = true
        }
    }
    
    func gameOver() {
        for button in inputButtons {
            button.isEnabled = false
        }
        deleteButton.isEnabled = false
        restart.isEnabled = true
        resultTextView.text = "Congratulation\n Total : \(sum) times"
    }
}

