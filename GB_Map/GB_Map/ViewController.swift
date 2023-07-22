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
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        //если приложение не активно, но данные все равно уходят (ниже)
        //locationManager?.allowsBackgroundLocationUpdates = true
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
        //моя локация
        //mapView.isMyLocationEnabled = true
    }
    
    // карта будет показывать центр нашей точки
    private func updateCamera(location: CLLocationCoordinate2D) {
        mapView.animate(toLocation: location)
    }
    
    // прорисовка маркера, здесь стандартный
    private func createMark(location: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: location)
        marker.map = mapView
    }
}

//просмотр координат куда мы нажали
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
