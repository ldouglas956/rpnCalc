//
//  ViewController.swift
//  Calculator
//
//  Created by Lance Douglas on 4/20/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var display: UILabel!
	
	
	
	
	
	
	var userIsTypingANumber: Bool = false
	
	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		if userIsTypingANumber {
			display.text = display.text! + digit
		} else {
			display.text = digit
			userIsTypingANumber = true
		}
		
	}
	
	
	
}

