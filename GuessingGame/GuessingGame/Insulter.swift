//
//  Insulter.swift
//  GuessingGame
//
//  Created by John Cieslik-Bridgen on 09/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import Foundation

class Insulter {

    var insultDictionary : [String: [String]]
    
    var niceWordsOne = [String]()
    var niceWordsTwo = [String]()
    
    init () {
        
        let path = NSBundle.mainBundle().pathForResource("insults", ofType:"plist")
        insultDictionary = NSDictionary(contentsOfFile: path!)! as! [String: [String]]
        
        
        niceWordsOne = ["Rare",
            "Sweet", "Fruitful",
            "Brave", "Sugared",
            "Flowering", "Precious",
            "Gallant", "Delicate",
        "Celestial"]
        
        niceWordsTwo = ["smilet",
            "toast", "cuckoo-bud",
            "nose-herb", "wafer-cake",
            "pigeon egg", "song",
            "true-penny", "companion",
            "spirit"]
    }
    
    func doInsult() -> String {
        
        var (w1, w2, w3) = getCussWords(insultDictionary)
        
        let coinFlip = Int(arc4random_uniform(4))
        let coinFlip2 = Int(arc4random_uniform(3))
        
        var thou = "Thou "
        if coinFlip2 != 1 {
            thou = ""
            w1 = w1.capitalizedString
        }
        
        print ("coinflip is \(coinFlip)")
        
        if coinFlip == 1 {
            return (thou + w1 + " " + w3 + "!")
        }
        return (thou + w1 + ", " + w2 + ", " + w3 + "!")
    }
    
    func getCussWords(cussDictionary: [String: [String]]) -> (String, String, String) {
        
//        for (key, value) in cussDictionary {
//            
//        }
        var firstWord = insultDictionary["first"]!
        var secondWord = insultDictionary["second"]!
        var thirdWord = insultDictionary["third"]!
        
        let length = UInt32(firstWord.count)
        
        let w1 = firstWord[Int(arc4random_uniform(length))]
        let w2 = secondWord[Int(arc4random_uniform(length))]
        let w3 = thirdWord[Int(arc4random_uniform(length))]
        
        return (w1, w2, w3)
    }

    func doCompliment() -> String {
        
        let length = UInt32(niceWordsOne.count)
        
        let first = Int(arc4random_uniform(length));
        let w1 = niceWordsOne[first]
        let second = Int(arc4random_uniform(length));
        let w2 = niceWordsTwo[second]
        
        return (w1 + " " + w2 + "! Well chosen!" )
    }
}



