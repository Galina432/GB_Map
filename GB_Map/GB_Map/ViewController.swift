//
//  ViewController.swift
//  GB_Map
//
//  Created by Irina on 22.07.2023.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {

    var currentLocation = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var locationManager: CLLocationManager?

    @IBOutlet weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLocationManager()
        setupCamera(location: currentLocation)
        updateCurrentLocation()
    }

    @IBAction func updateLocation(_ sender: Any) {
        updateCurrentLocation()
    }

    private func configureLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
    }
    
    private func updateCurrentLocation() {
        locationManager?.requestLocation()
        guard let location = locationManager?.location?.coordinate else { return }
        currentLocation = location
        print(currentLocation)
        updateCamera(location: location)
        createMark(location: location)
    }
    
    private func setupCamera(location: CLLocationCoordinate2D) {
        mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom:14)
    }
    
    private func updateCamera(location: CLLocationCoordinate2D) {
        mapView.animate(toLocation: location)
    }
    
    private func createMark(location: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: location)
        marker.map = mapView
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
       print(coordinate)
   }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       print(locations.first as Any)
   }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
