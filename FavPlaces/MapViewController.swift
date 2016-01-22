//
//  MapViewController.swift
//  FavPlaces
//
//  Created by John Cieslik-Bridgen on 21/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "addFav:")
        uilpgr.minimumPressDuration = 2.0

        map.addGestureRecognizer(uilpgr)
        // Do any additional setup after loading the view.
    }
    
    func addFav(gestureRecogniser: UIGestureRecognizer) {
        
        if (gestureRecogniser.state == UIGestureRecognizerState.Began) {
            //print ("bollocks")
            var touchPoint = gestureRecogniser.locationInView(self.map)
            print(touchPoint)
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            print(newCoordinate)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                var title = ""
                
                if error == nil {
                    
                    if let p =  placemarks?[0] {
                        
                        var street: String = ""
                        var subStreet: String = ""
                        
                        if p.subThoroughfare != nil {
                            subStreet = p.subThoroughfare!
                        }
                        if p.thoroughfare != nil {
                            street = p.thoroughfare!
                        }
                        title = (street + " " + subStreet)
                    }
                }
                if title == "" {
                    title = "Balls"
                }
                var annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
            })
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hello!")
        var userLocation = locations[0]
//        var latitude = userLocation.coordinate.latitude
//        var longitude = userLocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
        var span = MKCoordinateSpanMake(latDelta, lonDelta);
        var region = MKCoordinateRegionMake(userLocation.coordinate, span)
        
        self.map.setRegion(region, animated: true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
