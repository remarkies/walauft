//
//  LocationManager.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 10.12.20.
//

import Foundation
import MapKit
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? {
        didSet {
            if location != nil && self.sortedRegions != nil {
         
            self.sortedRegions!.sort(by: { (lhs, rhs) -> Bool in
              lhs.position.distance(from: location!) < rhs.position.distance(from: location!)
                // do sorting based on self.environmentObject
            })
          }
            objectWillChange.send()
        }
    }
    @Published var sortedRegions: [RegionModel]?
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
    }
   
}
