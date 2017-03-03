//
//  LogisticManager.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 03.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import GoogleMaps
import Alamofire
import SwiftyJSON

class LogisticManager {
    
    private let URLRoute = "https://maps.googleapis.com/maps/api/directions/json"
    private let originURLPath = "origin"
    private let destinationURLPath = "destination"
    private let keyURLPath = "key"
    private let constantURLPath = "alternatives=false"
    
    private let routesKey = "routes"
    private let legsKey = "legs"
    private let stepsKey = "steps"
    private let startLocationKey = "start_location"
    private let endLocationKey = "end_location"
    private let latitudeKey = "lat"
    private let longitudeKey = "lng"
    private let polylineKey = "polyline"
    private let pointsKey = "points"
    private let overviewPolylineKey = "overview_polyline"
    
    open func directRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        let stringURL = "\(URLRoute)?\(originURLPath)=\(origin.latitude),\(origin.longitude)&\(destinationURLPath)=\(destination.latitude),\(destination.longitude)&\(keyURLPath)=\(AppDelegate.APIKey)"
        
        Alamofire.request(stringURL).responseJSON { response in
            
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
    }
    
}
