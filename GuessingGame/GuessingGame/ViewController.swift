//
//  ViewController.swift
//  GuessingGame
//
//  Created by John Cieslik-Bridgen on 09/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theQuestion: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myGuess: UITextField!
    
    var fingers = 0
    let insulter = Insulter()
    
    @IBAction func doGuess(sender: UIButton) {
        self.view.endEditing(true)
        fingers = Int(arc4random_uniform(5) + 1)
        print ("fingers is \(fingers)")
        
        if let guess = NSNumberFormatter().numberFromString(myGuess.text!) {
            print ("guess is \(guess)")
            switch guess.integerValue {
            case fingers:
                messageLabel.text = insulter.doCompliment()
            default:
                messageLabel.text = insulter.doInsult()
            }
        } else {
            messageLabel.text = "Egads! Thou dost not deign to try?"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

