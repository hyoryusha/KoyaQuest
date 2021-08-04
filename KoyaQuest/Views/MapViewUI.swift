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
        mapView.setRegion(location.LMregion, animated: true)
        mapView.mapType = mapViewType
        mapView.isRotateEnabled = false
        mapView.addAnnotations(places)
        // mapView.showsUserLocation = true
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

    final class MapCoordinator: NSObject, MKMapViewDelegate {

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            switch annotation {
            case let cluster as MKClusterAnnotation:
                let annotationView = mapView.dequeueReusableAnnotationView(
                    withIdentifier: "cluster") as? MKMarkerAnnotationView ??
                MKMarkerAnnotationView(annotation: annotation,
                                       reuseIdentifier: "cluster")
                annotationView.tintColor = UIColor.koyaRed
                for clusterAnnotation in cluster.memberAnnotations {
                    if let place = clusterAnnotation as? PlaceAnnotation {
                        if place.isSection {
                            cluster.title = place.title
                            break
                        }
                    }
                }
                return annotationView
                case let placeAnnotation as PlaceAnnotation:
                let annotationView = mapView.dequeueReusableAnnotationView(
                    withIdentifier: "Landmark") as? MKMarkerAnnotationView ??
                MKMarkerAnnotationView(annotation: annotation,
                                       reuseIdentifier: "Landmark")
                annotationView.canShowCallout = true
                annotationView.glyphText = "❀"
                annotationView.markerTintColor = UIColor.koyaOrange
                annotationView.titleVisibility = .visible
                annotationView.clusteringIdentifier = "cluster"
                    if placeAnnotation.isSection {
                        annotationView.displayPriority = .defaultHigh
                    }

                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 105, height: 105))
                imageView.image = UIImage(named: placeAnnotation.image)
                imageView.contentMode = .scaleAspectFill
                annotationView.rightCalloutAccessoryView = imageView
                return annotationView
            default: return nil
            }


            /* guard let placeAnnotation = annotation as? PlaceAnnotation else {
                return nil
            }

            let annotationView = mapView.dequeueReusableAnnotationView(
                withIdentifier: "Landmark") as? MKMarkerAnnotationView ??
            MKMarkerAnnotationView(annotation: annotation,
                                   reuseIdentifier: "Landmark")
            annotationView.canShowCallout = true
            annotationView.glyphText = "❀"
            annotationView.markerTintColor = UIColor.koyaOrange
            annotationView.titleVisibility = .visible
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 105, height: 75))
            imageView.image = UIImage(named: placeAnnotation.image)
            imageView.contentMode = .scaleAspectFill
            annotationView.rightCalloutAccessoryView = imageView
            return annotationView
*/
        }
    }
}
