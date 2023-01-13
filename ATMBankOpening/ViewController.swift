//
//  ViewController.swift
//  ATMBankOpening
//
//  Created by Nikita on 12.01.23.
//

import UIKit
import GoogleMaps
import CoreLocation

final class ViewController: UIViewController {
    
    @IBOutlet weak var googleMapsView: GMSMapView!
    private var location = [CLLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMapsView.isMyLocationEnabled = true
        getBank()
    }
    
    private func getBank() {
        BelarusbankProvider().getCurrency { [weak self] allBank in
            guard let self else { return }
            for bank in allBank {
                self.drawMarkers(bank: bank)
            }
        } failure: { error in
            print(error)
        }
    }
        
        private func drawMarkers(bank: Location) {
            guard let bankXcoordinate = Double(bank.gps_x),
                  let bankYcoordinate = Double(bank.gps_y) else { return }
            let position = CLLocationCoordinate2D(latitude: bankXcoordinate, longitude: bankYcoordinate)
            let marker = GMSMarker(position: position)
            getAdditionalInfo(marker: marker, title: bank.address, snippet: bank.work_time)
            marker.map = googleMapsView
        }
        
        private func getAdditionalInfo(marker: GMSMarker, title: String, snippet: String) {
            marker.title = title
            marker.snippet = snippet
            googleMapsView.selectedMarker = marker
        }
        
    
}
