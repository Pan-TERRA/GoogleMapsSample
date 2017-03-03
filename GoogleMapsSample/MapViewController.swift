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
    
    @IBOutlet private weak var removeAllButton: UIButton!
    @IBOutlet private weak var directRouteButton: UIButton!
    @IBOutlet private weak var removeLabelButton: UIButton!
    @IBOutlet private weak var addLabelButton: UIButton!
    
    fileprivate var actionType = ActionType.nothing
    fileprivate var selectedMarker: GMSMarker?
    fileprivate var mapView: GMSMapView?
    fileprivate let logisticManager = LogisticManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 50.45,
                                              longitude: 30.44, zoom: 12)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView!.isMyLocationEnabled = true
        mapView!.accessibilityElementsHidden = false
        mapView!.settings.compassButton = true
        mapView!.delegate = self
        self.view.insertSubview(mapView!, at: 0)

    }
    
    // MARK: IBActions
    
    @IBAction func removeAllOnClick(_ sender: UIButton) {
        deselectAllButtons()
        actionType = .nothing
        mapView?.clear()
    }
    
    @IBAction func directRouteOnClick(_ sender: UIButton) {
        deselectAllButtons()
        sender.backgroundColor = UIColor.selectedControl
        actionType = .directRoute
    }
    
    @IBAction func removeLabelOnClick(_ sender: UIButton) {
        deselectAllButtons()
        sender.backgroundColor = UIColor.selectedControl
        actionType = .removeLabel
    }
    
    @IBAction func addLabelOnClick(_ sender: UIButton) {
        deselectAllButtons()
        sender.backgroundColor = UIColor.selectedControl
        actionType = .addLabel
    }
    
    private func deselectAllButtons() {
        directRouteButton.backgroundColor = UIColor.clear
        addLabelButton.backgroundColor = UIColor.clear
        removeLabelButton.backgroundColor = UIColor.clear
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        switch actionType {
        case .nothing: break
        case .removeLabel: break
        case .directRoute: break
        case .addLabel:
            let marker = GMSMarker()
            marker.position = coordinate
            marker.map = mapView
            selectedMarker = marker
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        switch actionType {
        case .removeLabel:
            marker.map = nil
        case .directRoute:
            if selectedMarker != nil && selectedMarker! != marker{
                logisticManager.directRoute(from: selectedMarker!.position, to: marker.position)
                selectedMarker = marker
            } else {
                selectedMarker = marker
            }
        case .addLabel: break
        case .nothing: break
        }
        return true
    }
}
