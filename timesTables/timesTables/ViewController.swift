//
//  ViewController.swift
//  timesTables
//
//  Created by John Cieslik-Bridgen on 13/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tv: UITableView!

    @IBOutlet weak var slider: UISlider!
    var currentTable: Int = 0
    
    @IBAction func sliderUpdate(sender: UISlider) {
        currentTable = Int(slider.value)
        setNameLabelText()
        tv.reloadData()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentTable = Int(slider.value)
        setNameLabelText()
    }
    
    func setNameLabelText() {
        nameLabel.text = "\(currentTable) times table"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(indexPath.row + 1) * \(currentTable) = " + "\((indexPath.row + 1) * currentTable)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 120
    }
    
}

