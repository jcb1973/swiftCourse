//
//  ViewController.swift
//  weatherview
//
//  Created by John Cieslik-Bridgen on 14/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var forecastText: UILabel!
    @IBOutlet weak var chosenCity: UITextField!

    @IBAction func showWeather(sender: UIButton) {
        
        var succeeded = false
       
        if let url = NSURL(string: "http://www.weather-forecast.com/locations/\(chosenCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-"))/forecasts/latest") {
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                //
                if let urlcontent = data {
                    
                    let webcontent = NSString(data: urlcontent, encoding: NSUTF8StringEncoding)
                    let splitString = "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    let forecastArray = webcontent!.componentsSeparatedByString(splitString)
                    
                    if forecastArray.count > 1 {
                        let theForecast = forecastArray[1].componentsSeparatedByString("</span>")
                        
                        if theForecast.count > 1 {
                            succeeded = true
                            let fcText = theForecast[0]
                            print (fcText)
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                //
                                self.forecastText.text = fcText.stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                            })
                        }
                    }
                    
                }
                if !succeeded {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //
                        self.forecastText.text = "Could not find weather"
                    })
                }
            }
            task.resume()
        } else {
            print ("in else")
            setErrorMessage("Invalid city?")
        }
        
    }
    
    func setErrorMessage(error: String) {
        forecastText.text = error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        forecastText.text = ""
        self.chosenCity.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.chosenCity.resignFirstResponder()
        return true
    }


}

