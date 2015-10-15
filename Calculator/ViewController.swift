//
//  ViewController.swift
//  Calculator
//
//  Created by Aubrey Lu on 10/13/15.
//  Copyright © 2015 Aubrey Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!

    var userIsInTheMiddleOfTypingNumber: Bool = false
    var decimalPressed: Bool = false
    
    @IBAction func appendDecimal() {
        if decimalPressed {
            return
        }
        else{
            decimalPressed = true
            display.text = display.text! + "."
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber
        {
        display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation1 { sqrt($0) }
        case "sin": performOperation1 { sin($0) }
        case "cos": performOperation1 { cos($0) }
        case "π" : performOperation1 { $0 * 3.14 }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation1(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        else{
            displayValue = 3.14
            enter()
        }
        
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        decimalPressed = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    


}

