//
//  Route.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 03.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class Route {
    
    var origin: Place?
    var destination: Place?
    var waypoints = [Place]()
    
    var polyline = ""
    
    static public func +(left: Route, right: Route) -> Route {
        guard left.origin != nil && right.origin != nil &&
            left.destination != nil && right.destination != nil &&
            left.destination?.coordinates == right.origin?.coordinates else {
                return left
        }
        
        let result = Route()
        result.origin = left.origin!
        result.destination = right.destination!
        result.waypoints.append(left.destination!)
        
        result.polyline = left.polyline + right.polyline
        
        return result
    }
    
    open func contains(place: Place) -> Bool {
        if origin != nil && origin!.coordinates == place.coordinates {
            return true
        }
        if destination != nil && destination!.coordinates == place.coordinates {
            return true
        }
        for waypoint in waypoints {
            if waypoint.coordinates == place.coordinates {
                return true
            }
        }
        return false
    }
}
