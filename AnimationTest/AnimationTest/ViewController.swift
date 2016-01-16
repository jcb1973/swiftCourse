//
//  ViewController.swift
//  AnimationTest
//
//  Created by John Cieslik-Bridgen on 16/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var controlButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    var counter = 1
    var isRunning = false
    //var timer = NSTimer()
    var images: [UIImage] = []
    
    
    @IBAction func controlAnimation(sender: AnyObject) {
        print ("controlAnimation+")
        
        print ("isRunning is \(isRunning)")
        
        if isRunning == true {
            stopTimer()
        } else {
            startTimer()
            
        }
        print ("isRunning is now \(isRunning)")
    }
    
    func stopTimer() {
        //timer.invalidate()
        image.stopAnimating()
        isRunning = false
        controlButton.setTitle("Start!", forState:UIControlState.Normal)
    }
    
    func runAnimation() {
       // print ("runAnimation+")
        if counter < 12 {
            counter++
        } else {
            counter = 1
        }
        
        let str = String(format:"mers-frame%02d.png", counter)
        //print(str)
        image.image = UIImage(named: str)
    }
    
    func startTimer() {
        //timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("runAnimation"), userInfo: nil, repeats: true)
        isRunning = true
        controlButton.setTitle("Stop!", forState:UIControlState.Normal)
        image.startAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //startTimer()
        
        for i in 1...12 {
            let str = String(format:"mers-frame%02d.png", i)
            images.append(UIImage(named: str)!)
        }
        image.animationImages = images
        image.animationDuration = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

