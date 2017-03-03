//
//  CLLocationCoordinate2D+Extension.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 03.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import GoogleMaps

extension CLLocationCoordinate2D: Equatable {
    
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    public static func !=(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return !(lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
    }
}
