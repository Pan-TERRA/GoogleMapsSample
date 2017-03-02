//
//  MapViewController.swift
//  GoogleMapsSample
//
//  Created by Vlad Krut on 02.03.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 50.45,
                                                          longitude: 30.44, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.accessibilityElementsHidden = false
        mapView.settings.compassButton = true
        mapView.delegate = self
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(50.45, 30.44)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }

}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("latitude: \(coordinate.latitude); longtitude: \(coordinate.longitude)")
    }
}

