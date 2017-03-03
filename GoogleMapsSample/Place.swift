//
//  Place.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 03.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import GoogleMaps

class Place {
    let coordinates: CLLocationCoordinate2D
    let adress: String
    
    public init(withCoordinates coordinates: CLLocationCoordinate2D, adress: String) {
        self.coordinates = coordinates
        self.adress = adress
    }
}
