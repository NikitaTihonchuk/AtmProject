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
    @IBOutlet weak var filterButtonHaveMoney: UIButton!
    @IBOutlet weak var filterButtonHaveNotMoney: UIButton!
    
    private var allMarkers = [GMSMarker]()
    private var dollarMarkers = [GMSMarker]()
    
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
        getAdditionalInfo(marker: marker, title: bank.address, snippet: "\(bank.work_time), в наличии:\(bank.currency)")
        if marker.searchATMWithDollars(currency: bank.currency) {
            dollarMarkers.append(marker)
        }
        allMarkers.append(marker)
        marker.map = googleMapsView
    }
        
    private func getAdditionalInfo(marker: GMSMarker, title: String, snippet: String) {
        marker.title = title
        marker.snippet = snippet
        if snippet.contains("Круглосуточно") {
            marker.icon = GMSMarker.markerImage(with: .systemGreen)
        }
        googleMapsView.selectedMarker = marker
    }
    
    @IBAction func searchATMIncludesMoneyDidTapped(_ sender: UIButton) {
        googleMapsView.clear()
        dollarMarkers.forEach { marker in
            marker.map = googleMapsView
            googleMapsView.selectedMarker = marker
        }
    }
    
    @IBAction func searchATMWithNoMoney(_ sender: UIButton) {
        googleMapsView.clear()
        allMarkers.forEach { marker in
            marker.map = googleMapsView
            googleMapsView.selectedMarker = marker
        }

    }
}

extension GMSMarker {
    
    func searchATMWithDollars(currency: String) -> Bool {
        var isHaveDollar = false
        
        if currency.isEmpty {
            isHaveDollar = false
        } else if currency.contains("USD") {
            isHaveDollar = true
        }
        return isHaveDollar
    }
    
}
