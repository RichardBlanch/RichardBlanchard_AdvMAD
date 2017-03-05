
import Foundation
import CoreLocation




//inspired by https://github.com/igroomgrim/CLLocationManager-Singleton-in-Swift
class LocationService: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationService()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        currentLocation = location
    }
    
    
    func getLocation()->CLLocation? {
        guard  currentLocation != nil else {
            return nil
        }
        return currentLocation!
    }
    
    
}
