//
//  ViewController.swift
//  A1_iOS_Rohankumar_C0796383
//
//  Created by user187410 on 1/25/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    
    @IBOutlet weak var directionBtn: UIButton!
    
    var locationManager = CLLocationManager()
    
    var destination: [CLLocationCoordinate2D] = []
    var i = 0
    var n = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        directionBtn.isHidden = true
        
        //we define the accuracy of the location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
        //request for the permission to access the location
        locationManager.requestWhenInUseAuthorization()
                
        //start updating the location
        locationManager.startUpdatingLocation()
        
        //1st Define the latitude and longitude
        let latitude: CLLocationDegrees = 43.64
        let longitude: CLLocationDegrees = -79.38
        
        //2nd display the marker on the map
        displayLocation(latitude: latitude, longitude: longitude, title: "Toronto City", subtitle: "You are in Ontario Province")
        
        //let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongPressAnnotation))
        //map.addGestureRecognizer(uilpgr)
        
        //Giving the delegate of MKMapViewDelegate to this class
        map.delegate = self
        
        //Double Tap
        addDoubleTap()
        
        //add PolyLine
        addPolyline()
        
        //add Polygon
        addPolygon()
        
        if bool == true{
            addDoubleTap()
        }
        
    
    }
    
    //MARK: - Draw Route
    
    @IBAction func drawRoute(_ sender: UIButton) {
        
        map.removeOverlays(map.overlays)
        //MARK: - Route between 1st to 2nd marker
        let sourcePlacemark = MKPlacemark(coordinate: points[0])
        let destinationPlacemark = MKPlacemark(coordinate: points[1])
            
            //request Diresction
            let directionRequest = MKDirections.Request()
            
            directionRequest.source = MKMapItem(placemark: sourcePlacemark)
            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
            
            //Transport Type
            directionRequest.transportType = .automobile
            
            //Calculate the direction
            
        let direction = MKDirections(request: directionRequest)
            direction.calculate { (response,error) in
                guard let directionResponse = response else { return }
                
                //Create Route
                let route = directionResponse.routes[0]
                
                //Drawing a Polyline
                self.map.addOverlay(route.polyline, level: .aboveRoads)
                
                //Define the Bounding map rect
                let rect = route.polyline.boundingMapRect
                self.map.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
            }
        
        
        //MARK: - Route between 2nd to 3rd marker
        let sourcePlacemark2 = MKPlacemark(coordinate: points[1])
        let destinationPlacemark2 = MKPlacemark(coordinate: points[2])
        
        //request Diresction
        let directionRequest2 = MKDirections.Request()
        
        directionRequest2.source = MKMapItem(placemark: sourcePlacemark2)
        directionRequest2.destination = MKMapItem(placemark: destinationPlacemark2)
        
        //Transport Type
        directionRequest2.transportType = .automobile
        
        //Calculate the direction
        
        let direction2 = MKDirections(request: directionRequest2)
        direction2.calculate { (response,error) in
            guard let directionResponse2 = response else { return }
            
            //Create Route
            let route2 = directionResponse2.routes[0]
            
            //Drawing a Polyline
            self.map.addOverlay(route2.polyline, level: .aboveRoads)
            
            //Define the Bounding map rect
            let rect2 = route2.polyline.boundingMapRect
            self.map.setVisibleMapRect(rect2, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }
        
        //MARK: - Route between 3rd to 1st marker
        
        
        let sourcePlacemark3 = MKPlacemark(coordinate: points[2])
        let destinationPlacemark3 = MKPlacemark(coordinate: points[0])
        
        //request Diresction
        let directionRequest3 = MKDirections.Request()
        
        directionRequest3.source = MKMapItem(placemark: sourcePlacemark3)
        directionRequest3.destination = MKMapItem(placemark: destinationPlacemark3)
        
        //Transport Type
        directionRequest3.transportType = .automobile
        
        //Calculate the direction
        
        let direction3 = MKDirections(request: directionRequest3)
        direction3.calculate { (response,error) in
            guard let directionResponse3 = response else { return }
            
            //Create Route
            let route3 = directionResponse3.routes[0]
            
            //Drawing a Polyline
            self.map.addOverlay(route3.polyline, level: .aboveRoads)
            
            //Define the Bounding map rect
            let rect3 = route3.polyline.boundingMapRect
            self.map.setVisibleMapRect(rect3, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }
    }
    
    
    //MARK: - didUpdate the location
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            //removePin()
            //print(locations.count)
            let userLocation = locations[0]
            
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            
            displayLocation(latitude: latitude, longitude: longitude, title: "You are here!", subtitle: "")
        }

    var latiarr = [Double]()
    var longiarr = [Double]()
    
    //MARK: - Double Tap
    func addDoubleTap()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTapsRequired = 2
        map.addGestureRecognizer(doubleTap)
        
    }
    //static var i = 0
    //static var n = 0
    var bool = false
    var points: [CLLocationCoordinate2D] = []
    
    @objc func dropPin(sender: UITapGestureRecognizer){
        
        var arr = ["A","B","C","D"]
        
            bool = false
            if(i < 3){
                let touchPoint = sender.location(in: map)
                let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
                //print(coordinate)
               
                let annotation = MKPointAnnotation()
                annotation.title = arr[i]
                i += 1
                annotation.coordinate = coordinate
                map.addAnnotation(annotation)
                
                var lat = annotation.coordinate.latitude
                //print(lat)
                latiarr.append(lat)
                
                var long = annotation.coordinate.longitude
                //print(long)
                longiarr.append(long)
                
                n += 1
                print(n)
                if n  == 3{
                    conv()
                }
                
                destination = points
                directionBtn.isHidden = false
                
            }else{
                print("Wrong")
                map.removeOverlays(map.overlays)
                directionBtn.isHidden = true
                removePin()
                i = 0
                n = 0
                latiarr.removeAll()
                longiarr.removeAll()
                points.removeAll()
                bool = true
                markerCheck()
            }

    }
    
    //MARK: - Marker Condition Checking
    func markerCheck()
    {
        if bool == true
        {
            addDoubleTap()
        }
    }
    
    //MARK: - Remove Pin
    func removePin()
    {
        for annotation in map.annotations{
            map.removeAnnotation(annotation)
        }
        
    }
    //MARK: - Adding Long Press Gesture for the annotation
    
    @objc func addLongPressAnnotation(gestureRecognizer: UIGestureRecognizer)
    {
        var arr:[String] = ["A","B","C"]
        
        for item in arr{
            
        
            let touchPoint = gestureRecognizer.location(in: map)
            let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
            
            //Add annotation for the coordinate
            let annotation = MKPointAnnotation()
            annotation.title = item
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
    }
    
    
    
    //MARK: - Diaplay User Location
    func displayLocation(latitude:CLLocationDegrees, longitude:CLLocationDegrees, title:String, subtitle:String){
        
        //Define Span
        let latDelta: CLLocationDegrees = 0.1
        let longDelta: CLLocationDegrees = 0.1
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        //Define the location
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //Define the Region
        let region = MKCoordinateRegion(center: location, span: span)
        
        //set the region for the map
        map.setRegion(region, animated: true)
        
        //Add annotation
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = location
        map.addAnnotation(annotation)
    }
    
    //MARK:- Converting latitude longitude
    
    func conv()
    {
        print("Hello")
        
        let point1 = CLLocationCoordinate2DMake(latiarr[0], longiarr[0])
        let point2 = CLLocationCoordinate2DMake(latiarr[1], longiarr[1])
        let point3 = CLLocationCoordinate2DMake(latiarr[2], longiarr[2])
        let point4 = CLLocationCoordinate2DMake(latiarr[0], longiarr[0])
        
        points = [point1,point2,point3,point4]
        addPolyline()
        addPolygon()
        drawDis()
    }
    
    //MARK: - Draw Polyine
    
    func addPolyline()
    {
        let polyline = MKPolyline(coordinates: points, count: points.count)
        map.addOverlay(polyline)
    }
    
    //MARK: - Draw Polygon
    
    func addPolygon()
    {
        let polygon = MKPolygon(coordinates: points, count: points.count)
        map.addOverlay(polygon)
    }
    
    //MARK: - Draw Distance from the user location to the marker
    func drawDis()
    {
        //MARK: - Draw Distance between user location to Marker A
        let sourcePlacemark = MKPlacemark(coordinate: locationManager.location!.coordinate)
        let destinationPlacemark = MKPlacemark(coordinate: points[0])
        
        //request Diresction
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        
        //Transport Type
        directionRequest.transportType = .automobile
        
        //Calculate the direction
        
        let direction = MKDirections(request: directionRequest)
        direction.calculate { (response,error) in
            guard let directionResponse = response else { return }
            
            //Create Route
            let route = directionResponse.routes[0]
            
            //Drawing a Polyline
            self.map.addOverlay(route.polyline, level: .aboveRoads)
            
            //Define the Bounding map rect
            let rect = route.polyline.boundingMapRect
            self.map.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }
    
        //MARK: - Draw Distance between user location to Marker B
        let sourcePlacemark2 = MKPlacemark(coordinate: locationManager.location!.coordinate)
        let destinationPlacemark2 = MKPlacemark(coordinate: points[1])
        
        //request Diresction
        let directionRequest2 = MKDirections.Request()
        
        directionRequest2.source = MKMapItem(placemark: sourcePlacemark2)
        directionRequest2.destination = MKMapItem(placemark: destinationPlacemark2)
        
        //Transport Type
        directionRequest2.transportType = .automobile
        
        //Calculate the direction
        
        let direction2 = MKDirections(request: directionRequest2)
        direction2.calculate { (response,error) in
            guard let directionResponse2 = response else { return }
            
            //Create Route
            let route2 = directionResponse2.routes[0]
            
            //Drawing a Polyline
            self.map.addOverlay(route2.polyline, level: .aboveRoads)
            
            //Define the Bounding map rect
            let rect2 = route2.polyline.boundingMapRect
            self.map.setVisibleMapRect(rect2, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }
        
        
        //MARK: - Draw Distance between user location to Marker C
        let sourcePlacemark3 = MKPlacemark(coordinate: locationManager.location!.coordinate)
        let destinationPlacemark3 = MKPlacemark(coordinate: points[2])
        
        //request Diresction
        let directionRequest3 = MKDirections.Request()
        
        directionRequest3.source = MKMapItem(placemark: sourcePlacemark3)
        directionRequest3.destination = MKMapItem(placemark: destinationPlacemark3)
        
        //Transport Type
        directionRequest3.transportType = .automobile
        
        //Calculate the direction
        
        let direction3 = MKDirections(request: directionRequest3)
        direction3.calculate { (response,error) in
            guard let directionResponse3 = response else { return }
            
            //Create Route
            let route3 = directionResponse3.routes[0]
            
            //Drawing a Polyline
            self.map.addOverlay(route3.polyline, level: .aboveRoads)
            
            //Define the Bounding map rect
            let rect3 = route3.polyline.boundingMapRect
            self.map.setVisibleMapRect(rect3, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }
    }

}


    
extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: " Drop Location ")
               pinAnnotation.animatesDrop = true
               pinAnnotation.pinTintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
               pinAnnotation.canShowCallout = true
               pinAnnotation.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               return pinAnnotation
    }
    
    //MARK: - Callout Accesory Control tapped
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            let alertController = UIAlertController(title: "Selected City", message: "A nice city to visit!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:  nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline{
            let rendrer = MKPolylineRenderer(overlay: overlay)
            rendrer.strokeColor = UIColor.blue
            rendrer.lineWidth = 3
            return rendrer
        }else if overlay is MKPolygon{
            let rendrer = MKPolygonRenderer(overlay: overlay)
            rendrer.fillColor = UIColor.red.withAlphaComponent(0.5)
            rendrer.strokeColor = UIColor.green
            rendrer.lineWidth = 2
            return rendrer
        }
        return MKOverlayRenderer()
    }
}
