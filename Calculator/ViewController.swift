//
//  ViewController.swift
//  Calculator
//
//  Created by Lance Douglas on 4/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
// Stanford Computer Science: CS193P
// RPN Calculator

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		view.backgroundColor = defaultColor
	}
	
	// MARK: Variables
	@IBOutlet weak var display: UILabel!
	
	let PI = 3.14159265359
	let flashColor = UIColor.lightGrayColor()
	let defaultColor = UIColor.init(colorLiteralRed: 215, green: 220, blue: 231, alpha: 1)
	var userIsTypingANumber = false
	var operandStack = Array<Double>()
	var displayValue: Double {
		get {
			return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
		}
		set {
			display.text = String(newValue)
			userIsTypingANumber = false
		}
	}
	
	// MARK: IBActions
	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		if display.text!.containsString(".") && digit == "." {
			// Do Nothing
		} else {
			if userIsTypingANumber {
				display.text! += digit
			} else {
				display.text = digit
				userIsTypingANumber = true
			}
		}
	}
	//
	@IBAction func appendPI(sender: UIButton) {
		if userIsTypingANumber {
			displayValue = PI * NSNumberFormatter().numberFromString(display.text!)!.doubleValue
			enter()
		} else {
			display.text! = String(PI)
			enter()
		}
		backgroundFlash()
	}
	//
	@IBAction func operate(sender: UIButton) {
		let operation = sender.currentTitle!
		if userIsTypingANumber {
			enter()
		}
		switch operation {
		case "×": dualOperation { $1 * $0 }
		case "÷":
			if operandStack.last != 0 {
			dualOperation { $1 / $0 }
			} else {
			errorReset()
			}
		case "+": dualOperation { $1 + $0 }
		case "−": dualOperation { $1 - $0 }
		case "√":
			if operandStack.last > 0 {
			singleOperation { sqrt($0) }
			} else {
			errorReset()
			}
		case "sin": singleOperation {sin($0*self.PI/180)}
		case "cos": singleOperation {cos($0*self.PI/180)}
		default: break
		}
		backgroundFlash()
	}
	//
	@IBAction func enter() {
		userIsTypingANumber = false
		if display.text == "Error" {
			displayValue = 0.0
		} else {
			operandStack.append(displayValue)
		}
		print("operand Stack = \(operandStack)")
		backgroundFlash()
	}
	//
	@IBAction func resetButtonPressed() {
		display.text = "0"
		operandStack = []
		userIsTypingANumber = false
		backgroundFlash()
	}
	
	// MARK: Functions
	func dualOperation(operation: (Double, Double) -> Double) {
		if operandStack.count >= 2 {
			displayValue = operation(operandStack.removeLast(),  operandStack.removeLast())
			enter()
		}
	}
	//
	func singleOperation(operation: Double -> Double) {
		if operandStack.count >= 1 {
			displayValue = operation(operandStack.removeLast())
			enter()
		}
	}
	//
	func errorReset() {
		display.text = "Error"
		operandStack = [0]
	}
	//
	func backgroundFlash() {
		view.backgroundColor = flashColor
		NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.changeToOriginalColor), userInfo: nil, repeats: false)
	}
	//
	func changeToOriginalColor() {
		view.backgroundColor = defaultColor
	}
}

