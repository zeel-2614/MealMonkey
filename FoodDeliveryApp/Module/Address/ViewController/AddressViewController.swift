//
//  AddressViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import UIKit
import MapKit
import CoreLocation

protocol ChangeAddressDelegate: AnyObject {
    func didSelectAddress(_ address: String)
}

/// A view controller that allows users to search, select, and confirm an address using a map view.
class AddressViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate {
    
    weak var delegate: ChangeAddressDelegate?
    @IBOutlet weak var btnRedirectCurrentAddress: UIButton!
    @IBOutlet weak var btnSavedAddress: UIButton!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    /// Location manager for fetching device's current location.
    let locationManager = CLLocationManager()
    /// Geocoder for converting coordinates to human-readable addresses and vice versa.
    let geocoder = CLGeocoder()
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupUI()
        setupMap()
    }
    /// Sets up the UI components.
    private func setupUI() {
        /// Applies styling to the search text field.
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtSearchAddress])
        setPadding(textfield: [txtSearchAddress])
        mapView.delegate = self
        
        /// Adds a back button with a title in the navigation bar.
        setLeftAlignedTitleWithBack(
            "Change Address",
            target: self,
            action: #selector(BackBtnTapped)
        )
        /// Adds a tap gesture recognizer to the map view for placing pins.
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mapTapped(_:))
        )
        mapView.addGestureRecognizer(tapGesture)
        
        /// Adds an action to trigger address search when the user presses return.
        txtSearchAddress.addTarget(
            self,
            action: #selector(searchAddress),
            for: .editingDidEndOnExit
        )
    }
    
    /// Adds left and right padding to given text fields.
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Sets up the map with a default location and a pin.
    private func setupMap() {
        mapView.showsUserLocation = true
        // Default location (e.g., your city)
        let defaultLocation = CLLocationCoordinate2D(
            latitude: 23.0225,
            longitude: 72.5714
        )
        centerMap(on: defaultLocation)
        addPinAtCenterAndReverseGeocode()
    }
    // MARK: - Map tap
    /// Triggered when the user taps on the map.
    @objc func mapTapped(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        updatePinAndAddress(at: coordinate)
    }
    
    /// Updates the pin on the map and fetches the address for a given coordinate.
    private func updatePinAndAddress(at coordinate: CLLocationCoordinate2D) {
        // Remove previous pins except user location
        mapView.removeAnnotations(
            mapView.annotations.filter { !($0 is MKUserLocation) }
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Loading address..."
        mapView.addAnnotation(annotation)
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        /// Reverse geocodes the coordinate to get a human-readable address.
        geocoder.reverseGeocodeLocation(location) {
            [weak self] placemarks, error in
            guard let self = self else { return }
            var fullAddress = "Unknown Location"
            if let placemark = placemarks?.first {
                let name = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                fullAddress = "\(name), \(city), \(country)"
                annotation.title = name
                annotation.subtitle = "\(city), \(country)"
            }
            self.mapView.selectAnnotation(annotation, animated: true)
            self.delegate?.didSelectAddress(fullAddress)
            locationManager.stopUpdatingLocation()
            // Store current location in UserDefaults
            UserDefaults.standard.set(fullAddress, forKey: "currentAddress")
        }
    }
    // MARK: - Search Address
    /// Searches for an address entered in the text field and moves the map to that location.
    @objc func searchAddress() {
        guard let query = txtSearchAddress.text, !query.isEmpty else { return }
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first,
                  let location = placemark.location
            else { return }
            let coordinate = location.coordinate
            self.centerMap(on: coordinate)
            self.updatePinAndAddress(at: coordinate)
        }
        txtSearchAddress.resignFirstResponder()
    }
    // MARK: - Current Location
    /// Action for the "Current Location" button. Starts fetching the user's location.
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
        locationManager.startUpdatingLocation() // Start fetching current location
    }
    // MARK: - Map helpers
    /// Centers the map on a specific location.
    func centerMap(
        on location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000
    ) {
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(region, animated: true)
    }
    
    /// Adds a pin at the map's center and fetches the address.
    func addPinAtCenterAndReverseGeocode() {
        let centerCoord = mapView.centerCoordinate
        updatePinAndAddress(at: centerCoord)
    }
    // MARK: - Location Permission
    /// Checks and requests location permission from the user.
    func checkLocationPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                showPermissionAlert()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        } else {
            let status = CLLocationManager.authorizationStatus()
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else if status == .denied || status == .restricted {
                showPermissionAlert()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    /// Shows an alert prompting the user to enable location permissions.
    func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Location Permission Needed",
            message:
                "Please enable location access in Settings to use this feature.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(
            UIAlertAction(
                title: "Open Settings",
                style: .default,
                handler: { _ in
                    if let settingsURL = URL(
                        string: UIApplication.openSettingsURLString
                    ) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
            )
        )
        present(alert, animated: true)
    }
    // MARK: - CLLocationManagerDelegate
    /// Called when the location manager updates the user's location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = location.coordinate
        centerMap(on: coordinate)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            var fullAddress = "Unknown Location"
            if let placemark = placemarks?.first {
                let name = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                fullAddress = "\(name), \(city), \(country)"
            }
            
            // Save to UserDefaults
            UserDefaults.standard.set(fullAddress, forKey: "currentAddress")
            UserDefaults.standard.synchronize()
            
            // Update pin on map
            self.updatePinAndAddress(at: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    /// Called when location manager fails to get location.
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    // MARK: - Navigation
    /// Action for the back button. Sends selected address to delegate before navigating back.
    @objc func BackBtnTapped() {
        if let selectedAnnotation = mapView.annotations.first(where: {
            !($0 is MKUserLocation)
        }) {
            if let title = selectedAnnotation.title ?? "", !title.isEmpty {
                delegate?.didSelectAddress(title)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    // MARK: - MKMapViewDelegate
    /// Provides a custom annotation view for map pins.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier
        )
        if annotationView == nil {
            annotationView = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
            annotationView?.canShowCallout = true
            // Set your custom image
            annotationView?.image = UIImage(named: "ic_current_position")
            // Optional: center the pin bottom on the coordinate
            annotationView?.centerOffset = CGPoint(
                x: 0,
                y: -(annotationView?.image?.size.height ?? 0) / 2
            )
            // Optional: add a detail button on callout
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
