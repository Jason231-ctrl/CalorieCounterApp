//
//  MapViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var manager:CLLocationManager!
    var currentCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2D()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personModel:PersonModel?
    @IBOutlet weak var dietLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        personModel = PersonModel(context: managedObjectContext)
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        dietLabel.text = personModel?.getPersonFirst()?.value(forKey: "diet") as! String
    }
    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex){
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.satellite
        case 2:
            map.mapType = MKMapType.hybrid
        default:
            map.mapType = MKMapType.standard
        }
    }
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()){
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something went wrong with location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        let userLocation:CLLocation = locations[0]
        let coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinate, span: span)
        currentCoordinate.longitude = userLocation.coordinate.longitude
        currentCoordinate.latitude = userLocation.coordinate.latitude
        self.map.setRegion(region, animated: true)
        let currentLocation = MKPointAnnotation()
        currentLocation.coordinate = coordinate
        currentLocation.title = "Current Local"
        self.map.addAnnotation(currentLocation)
        
        //make it so it request for person entry
         let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = personModel?.getPersonFirst()!.value(forKey: "diet") as! String
         let span2: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.15, longitudeDelta: 0.15)
         let region2: MKCoordinateRegion = MKCoordinateRegion.init(center: self.currentCoordinate, span: span2)
         request.region = region2
         let searched = MKLocalSearch(request: request)
         searched.start { response, _ in
             guard let response = response else {
                 return
             }
             var matchingItems:[MKMapItem] = []
             matchingItems = response.mapItems
             for i in 1...matchingItems.count-1 {
                 let place = matchingItems[i].placemark
                 let tempCord = CLLocationCoordinate2D(latitude:(place.location?.coordinate.latitude)!, longitude: (place.location?.coordinate.longitude)!)
                 let annotation = MKPointAnnotation()
                 annotation.coordinate = tempCord
                 annotation.title = place.name
                 let addressString = "\(place.subThoroughfare ?? "") \(place.thoroughfare ?? "") \(place.subAdministrativeArea ?? "") \(place.administrativeArea ?? "") \(place.postalCode ?? "")"
                 print(place)
                 annotation.subtitle = addressString
                 self.map.addAnnotation(annotation)
             }
         }
         
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    @IBAction func search(_ sender: Any) {
        self.map.removeAnnotations(map.annotations)
        let currentLocation = MKPointAnnotation()
        currentLocation.coordinate = currentCoordinate
        currentLocation.title = "Current Local"
        self.map.addAnnotation(currentLocation)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchField.text
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: self.currentCoordinate, span: span)
        request.region = region
        let searched = MKLocalSearch(request: request)
        searched.start { response, _ in
            guard let response = response else {
                return
            }
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count-1 {
                let place = matchingItems[i].placemark
                let tempCord = CLLocationCoordinate2D(latitude:(place.location?.coordinate.latitude)!, longitude: (place.location?.coordinate.longitude)!)
                let annotation = MKPointAnnotation()
                annotation.coordinate = tempCord
                annotation.title = place.name
                let addressString = "\(place.subThoroughfare ?? "") \(place.thoroughfare ?? "") \(place.subAdministrativeArea ?? "") \(place.administrativeArea ?? "") \(place.postalCode ?? "")"
                
                annotation.subtitle = addressString
                self.map.addAnnotation(annotation)
            }
        }
    }

}
