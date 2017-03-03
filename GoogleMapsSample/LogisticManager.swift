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
    
    private let statusKey = "status"
    
    private let routesKey = "routes"
    private let legsKey = "legs"
    private let stepsKey = "steps"
    
    private let startLocationKey = "start_location"
    private let startAdressKey = "start_address"
    
    private let endLocationKey = "end_location"
    private let endAdressKey = "end_address"
    
    private let latitudeKey = "lat"
    private let longitudeKey = "lng"
    
    private let polylineKey = "polyline"
    private let pointsKey = "points"
    private let overviewPolylineKey = "overview_polyline"
    
    var selectedRoute: Dictionary<NSObject, AnyObject>!
    var overviewPolyline: Dictionary<NSObject, AnyObject>!
    var originCoordinate: CLLocationCoordinate2D!
    var destinationCoordinate: CLLocationCoordinate2D!
    var originAddress: String!
    var destinationAddress: String!
    
    
    open func directRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, withCompletionHandler handler: @escaping ((Route?, StatusCode) -> Void)) {
        
        let stringURL = "\(URLRoute)?\(originURLPath)=\(origin.latitude),\(origin.longitude)&\(destinationURLPath)=\(destination.latitude),\(destination.longitude)&\(keyURLPath)=\(AppDelegate.APIKey)"
        
        Alamofire.request(stringURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let rawStatus = json[self.statusKey].stringValue
                let status = StatusCode(rawValue: rawStatus)!
                
                guard status == .ok else {
                    handler(nil, status)
                    return
                }
                
                let resultRoute = Route()
                
                let route = json[self.routesKey][0]
                
                let pointsOfPolyline = route[self.overviewPolylineKey][self.pointsKey].stringValue
                
                let leg = route[self.legsKey][0]
                let legsCount = route[self.legsKey].arrayValue.count
                
                let originCoordinates = CLLocationCoordinate2DMake(leg[self.startLocationKey][self.latitudeKey].doubleValue, leg[self.startLocationKey][self.longitudeKey].doubleValue)
                let originAdress = leg[self.startAdressKey].stringValue
                let origin = Place(withCoordinates: originCoordinates, adress: originAdress)
                
                let destinationCoordinates = CLLocationCoordinate2DMake(leg[self.endLocationKey][self.latitudeKey].doubleValue, leg[self.endLocationKey][self.longitudeKey].doubleValue)
                let destinationAdress = leg[legsCount - 1]["end_address"].stringValue
                let destination = Place(withCoordinates: destinationCoordinates, adress: destinationAdress)
                
                resultRoute.origin = origin
                resultRoute.destination = destination
                resultRoute.polyline = pointsOfPolyline
                
                handler(resultRoute, status)
                
            case .failure(let error):
                print(error)
                handler(nil, StatusCode.unknownError)
            }
            
        }
    }

}

