//
//  MapViewUI.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//


import SwiftUI
import MapKit

struct MapViewUI: UIViewRepresentable {
    let location: Landmark
    let mapViewType: MKMapType
    let places: [PlaceAnnotation]
    
    func makeUIView(context: Context) -> some MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(location.LMregion, animated: true) //was false
        mapView.mapType = mapViewType
        mapView.isRotateEnabled = false
        mapView.addAnnotations(places)
        //mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: UIViewType, context: Context) {
        mapView.mapType = mapViewType
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func makeCoordinator() -> MapCoordinator {
        .init()
    }
    
    final class MapCoordinator: NSObject , MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let placeAnnotation = annotation as? PlaceAnnotation else {
                return nil
            }
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Landmark") as? MKMarkerAnnotationView ??
            MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Landmark")
            annotationView.canShowCallout = true
            annotationView.glyphText = "❀"
            annotationView.markerTintColor = UIColor(red: 229 / 255, green: 127 / 255, blue: 42 / 255 , alpha: 1.0)
            annotationView.titleVisibility = .visible
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 105, height: 75))
            imageView.image = UIImage(named: placeAnnotation.image)
            imageView.contentMode = .scaleAspectFill
            annotationView.rightCalloutAccessoryView = imageView
            return annotationView
        
        }
    }
}
