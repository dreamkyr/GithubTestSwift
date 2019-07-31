//
//  MapViewController.swift
//  githubTest
//
//  Created by dreams on 7/31/19.
//  Copyright © 2019 Dreams. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var webservice: GithubService!
    var username = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webservice = self
        self.webservice.getUserLocation(name: username)
    }

    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}

extension MapViewController: GithubService {
    func webServiceGetError(_ error: NetworkError) {
        print(error.localizedDescription)
    }
    
    func webServiceGetResponse(data: [Contributor]) {
        
    }
    
    func webServiceGetLocation(location: String) {
        getCoordinateFrom(address: location) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            DispatchQueue.main.async {
                let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }
}
