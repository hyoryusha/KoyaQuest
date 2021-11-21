//
//  PlaceAnnotations.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/12.
//

import SwiftUI
import CoreLocation
import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var title: String?
    var image: String
    var coordinate: CLLocationCoordinate2D
    var isSection: Bool

    init(title: String, image: String, coordinate: CLLocationCoordinate2D, isSection: Bool) {
        self.title = title
        self.image = image
        self.coordinate = coordinate
        self.isSection = isSection
    }
}

var allPlaces: [PlaceAnnotation] = getPlaceAnnotations()

func getPlaceAnnotations() -> [PlaceAnnotation] {
    var places: [PlaceAnnotation] = []
    Landmark.allLandmarks.forEach { landmark in
        let newItem = PlaceAnnotation(
         title: landmark.name,
         image: landmark.imageName,
         coordinate: landmark.coordinate,
         isSection: landmark.isSection
        )
        places.append(newItem)
    }
    return places
}
