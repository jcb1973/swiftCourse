//
//  ViewController.swift
//  TimerTest
//
//  Created by John Cieslik-Bridgen on 10/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var startButton: UIBarButtonItem!
    

    var timeSelected: [String: Int] = [
        "Hard": (60 * 7),
        "Medium": (60 * 5) + 30,
        "Soft": (60 * 4) + 30]
    
    //var pickerData: [[String]] = [[String]]()
    let pickerData = ["Hard", "Medium", "Soft"]

    var timeRemaining = 0
    var timeChosen = ""
    
    var isRunning = false
    var shouldReset = false
    var timer = NSTimer()
    
    
    var buttonBeep : AVAudioPlayer?
    
    var minutesSelected = 0
    var secondsSelected = 0
    
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    @IBOutlet weak var timeDisplayLabel: UILabel!
    
    @IBAction func actionPressed(sender: UIBarButtonItem) {
        
        let action = sender.title!
        
        if action == "Start" {
            doStart()
        } else if action == "Reset" {
            doReset()
        } else if action == "Stop" {
            doStop()
        }
    }
    func getTimeRemaining() -> Int {
        return timeRemaining
    }

    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    func updateButtonState(newState: String) {
        
        //print("isRunning is \(isRunning) updating for \(newState)")
        
        switch newState {
            case "start":
                resetButton.enabled = false
                startButton.enabled = true
                stopButton.enabled = false
            case "running":
                resetButton.enabled = false
                startButton.enabled = false
                stopButton.enabled = true
            case "paused":
                resetButton.enabled = true
                startButton.enabled = true
                stopButton.enabled = false
            case "finished":
                resetButton.enabled = true
                startButton.enabled = false
                stopButton.enabled = false
            default:
                break
        }
    }
    
    func fireSecond() {
        
        timeRemaining--
        updateUI(timeRemaining)
        
        if timeRemaining == 0 {
            isRunning = false
            timer.invalidate()
            updateButtonState("finished")
            doFinishedAlert()
        }
    }
    
    func doFinishedAlert() {
        
        // create the alert
        let alert = UIAlertController(title: "Finished!", message: "Your egg is ready", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        buttonBeep?.play()
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func updateUI(time: Int) {
    
        let minutes = time / 60
        let seconds = time % 60;
        //let timeString =
        timeDisplayLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func doStart() {
        //print ("should reset is \(shouldReset)")
        if isRunning {
            print("hit start while running - no op")
            return
        }
        
        isRunning = true
        if shouldReset {
            timeRemaining = timeSelected[timeChosen]!
            updateUI(timeRemaining)
        }
        if !picker.hidden {
            picker.hidden = true
            timeDisplayLabel.hidden = false
            
        }
        updateButtonState("running")
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("fireSecond"), userInfo: nil, repeats: true)
        
    }
    
    func doReset() {
        
        if isRunning {
            print("hit reset while running - no op")
            return
        }
        isRunning = false
        shouldReset = true
        updateButtonState("start")
        updateUI(timeRemaining)
        timeDisplayLabel.hidden = true
        self.picker.hidden = false
        
    }
  
    func doStop() {
        
        if !isRunning {
            print("hit stop while not running - no op")
            return
        }
        shouldReset = false
        isRunning = false
        updateButtonState("paused")
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Input data into the Array:
//        pickerData.append(minutes.map { String($0) })
//        pickerData.append(seconds.map { String($0) })
//        
        print(pickerData)
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.hidden = true
        
        if let buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav") {
            self.buttonBeep = buttonBeep
        }
        doReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print ("setting minutesSelected to \(pickerData[row])")
        timeChosen = pickerData[row]
        return pickerData[row]
    }
    


}

