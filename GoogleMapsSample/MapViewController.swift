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
    fileprivate var selectedMarker: GMSMarker? {
        willSet {
            selectedMarker?.icon = nil
        }
        didSet {
            let image = GMSMarker.markerImage(with: UIColor.selectedControl)
            selectedMarker?.icon = image
        }
    }
    fileprivate var mapView: GMSMapView?
    fileprivate let logisticManager = LogisticManager()
    
    fileprivate var route: Route? {
        didSet {
            if route != nil {
                let path = GMSPath(fromEncodedPath: route!.polyline)
                routePolyline = GMSPolyline(path: path)
                routePolyline?.map = mapView
            } else {
                routePolyline?.map = nil
                routePolyline = nil
            }
        }
    }
    fileprivate var routePolyline: GMSPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 50.45,
                                              longitude: 30.44, zoom: 12)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView!.isMyLocationEnabled = true
        mapView!.accessibilityElementsHidden = false
        mapView!.settings.compassButton = true
        mapView!.delegate = self
        mapView!.padding = UIEdgeInsetsMake(addLabelButton.frame.height, 0.0, 0.0, 0.0)
        self.view.insertSubview(mapView!, at: 0)
        
    }
    
    // MARK: IBActions
    
    @IBAction func removeAllOnClick(_ sender: UIButton) {
        deselectAllButtons()
        actionType = .nothing
        route = nil
        selectedMarker = nil
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
    
    fileprivate func removeMarker(_ marker: GMSMarker) {
        if selectedMarker == marker {
            selectedMarker = nil
        }
        marker.map = nil
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
            marker.appearAnimation = .pop
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        switch actionType {
        case .removeLabel:
            removeMarker(marker)
        case .directRoute:
            if selectedMarker != nil && selectedMarker! != marker {
                logisticManager.directRoute(from: selectedMarker!.position, to: marker.position, withCompletionHandler: { (route, status) in
                    
                    guard status == StatusCode.ok else {
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: "Error", message: status.rawValue, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    
                    if self.route == nil {
                        self.route = route
                    } else {
                        self.route = self.route! + route!
                    }
                    
                })
                selectedMarker = marker
            } else {
                selectedMarker = marker
            }
        case .nothing:
            selectedMarker = marker
        case .addLabel: break
        }
        return true
    }
    
}
