//
//  StatusCode.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 03.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

public enum StatusCode: String {
    case ok = "OK"
    case notFound = "NOT_FOUND"
    case zeroResults = "ZERO_RESULTS"
    case maxWaypointsExceeded = "MAX_WAYPOINTS_EXCEEDED"
    case invalidRequest = "INVALID_REQUEST"
    case overQueryyLimit = "OVER_QUERY_LIMIT"
    case requestDenied = "REQUEST_DENIED"
    case unknownError = "UNKNOWN_ERROR"
}
