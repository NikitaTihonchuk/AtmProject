//
//  ViewController.swift
//  ATMBankOpening
//
//  Created by Nikita on 12.01.23.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var googleMapsView: GMSMapView!
    
    var location = [CLLocation]()
    var data = [Location]()
    var markers = [GMSMarker()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMapsView.isMyLocationEnabled = true
        googleMapsView.delegate = self
        getBankLocation()
        self.view.backgroundColor = .red
    }
    
    func getBankLocation() {
        BelarusbankProvider().getCurrency(success: { [weak self] result in
            guard let self else { return }
            for terminal in result {
                let locat = CLLocation(latitude: Double(terminal.gps_x)!, longitude: Double(terminal.gps_y)!)
            self.location.append(locat)
            }
            self.drawMarkers(coordinates: self.location)
        }, failure: { errorString in
        })
    }
    
    func drawMarkers(coordinates: [CLLocation]) {
        for coordinate in coordinates {
           let marker = GMSMarker(position: coordinate.coordinate)
            marker.map = googleMapsView
            self.markers.append(marker)
        }
    }
}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if self.markers.contains(marker) {
            
        }
        return true
    }
}

