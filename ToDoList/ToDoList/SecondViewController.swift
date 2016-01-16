//
//  SecondViewController.swift
//  ToDoList
//
//  Created by John Cieslik-Bridgen on 14/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

var toDoItems = ToDoItems()

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoTextField: UITextField!
    @IBAction func tappedDone(sender: UIBarButtonItem) {
        
        // write it somewhere
        let newItem = todoTextField.text
        toDoItems.addItem(newItem!)
        todoTextField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.todoTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.todoTextField.resignFirstResponder()
        return true
    }


}

