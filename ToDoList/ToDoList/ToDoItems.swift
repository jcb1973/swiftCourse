//
//  ToDoItems.swift
//  ToDoList
//
//  Created by John Cieslik-Bridgen on 14/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import Foundation

class ToDoItems {
    
    var items = [String]()
    
    init() {
        
        if let loadedDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems"){
            
            print ("Loaded saved list")
            
            items = loadedDoList as! [String];
            
        }
        
//        if NSUserDefaults.standardUserDefaults().objectForKey("toDoItems") != nil {
//            items = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems") as! [String]
//        }
    }
    
    func getItemForIndex(index: Int) -> String {
        
        return items[index]
    }
    
    func addItem(anItem: String) {
        
        items.append(anItem)
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: "toDoItems")
    }
    
    func removeItemAtIndex(index: Int) {
        
        items.removeAtIndex(index)
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: "toDoItems")
    }
    
    func count() -> Int {
        return items.count
    }
}
