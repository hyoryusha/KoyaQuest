//
//  Landmarks.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
//

import SwiftUI
import CoreLocation
import Foundation
import MapKit

enum KoyaSection : String, CaseIterable, Codable {
    
   case daimonSection        = "Western Entrance"
   case garanSection         = "Danjō Garan"
   case kongobujiSection     = "Kongōbuji Area"
   case northSection         = "Northern Area"
   case midSection           = "Southern Area"
   case okunoinSection       = "Oku-no-in Area"
}

struct Location: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

struct Detail: Hashable, Codable {
    var headerOne:  String
    var bodyOne:    String
    var headerTwo:  String
    var bodyTwo:    String
}

struct Landmark:  Hashable, Codable, Identifiable  {
    
    var id: Int
    var title: String {name}
    var name:       String
    var jname:      String
    var romaji:     String
    var imageName:  String
    var section:    KoyaSection
    var area:   String
    
    
    
    var isSection:  Bool //this can be removed
    var details: Detail
    var image: Image {
        Image(imageName)
    }
    private var location: Location
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude)
    }
    
    var LMregion: MKCoordinateRegion {
        return MKCoordinateRegion(center: self.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
    }
    
    
    static let allSections = [KoyaSection.daimonSection ,
                              KoyaSection.garanSection,
                              KoyaSection.kongobujiSection,
                              KoyaSection.midSection ,
                              KoyaSection.northSection,
                              KoyaSection.okunoinSection
    ]
    static let allLandmarks = Bundle.main.decode([Landmark].self, from: "Landmarks.json")
    static let example = allLandmarks[1]
}
    

