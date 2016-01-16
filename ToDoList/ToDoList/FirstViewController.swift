//
//  FirstViewController.swift
//  ToDoList
//
//  Created by John Cieslik-Bridgen on 14/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tv.reloadData()
    }
    
    // MARK: tableViewDataSource needed methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // UPDATE THIS
        return toDoItems.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // UPDATE THIS
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let text = toDoItems.getItemForIndex(indexPath.row)
        cell!.textLabel?.text = text
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //
        print ("got here index path is \(indexPath.row)")
        toDoItems.removeItemAtIndex(indexPath.row)
        tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }


}

