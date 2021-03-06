//
//  Area.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/15.
//

import SwiftUI
import CoreLocation
import MapKit

class Area: NSObject, Identifiable, ObservableObject {
    var id = UUID()
    var identifier: String
    var challenge: Challenge?
    var isTargetZone: Bool
    var location: CLLocation
    var radius: CLLocationDistance
    var region: CLCircularRegion {
        let region = CLCircularRegion(
            center: self.location.coordinate,
            radius: radius,
            identifier: identifier)
        return region
    }

    init(latitude: Double, longitude: Double,
         identifier: String,
         challenge: Challenge?,
         isTargetZone: Bool,
         radius: CLLocationDistance) {
        self.identifier = identifier
        self.challenge = challenge
        self.isTargetZone = isTargetZone
        self.radius = radius
        self.location = CLLocation(latitude: latitude,
                                   longitude: longitude)
    }

    static let greaterArea = Area(
        latitude: 34.2109456915934,
        longitude: 135.59842651113263,
        identifier: "Mount Kōya",
        challenge: nil,
        isTargetZone: false,
        radius: 5000)
}

// MARK: - Area Extension
extension Area: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        // get { // Swiftlint: (implicit_getter)
        return location.coordinate
        // }
    }

    var title: String? { // optional
        // get { // Swiftlint: (implicit_getter)
        return identifier
        // }
    }
}

// MARK: - REAL COORDS
let daimonArea = Area(
    latitude: 34.21316180316554,
    longitude: 135.57287620970556,
    identifier: "Daimon Area",
    challenge: daimonChallenge,
    isTargetZone: true,
    radius: 200
)

let westGaranArea = Area(
    latitude: 34.21405673565949,
    longitude: 135.57831499579422,
    identifier: "West Garan Area",
    challenge: vajraChallenge,
    isTargetZone: true,
    radius: 150
)

let eastGaranArea = Area(
    latitude: 34.212826723404326,
    longitude: 135.5813824754775,
    identifier: "East Garan Area",
    challenge: saigyoChallenge,
    isTargetZone: true,
    radius: 110
)

let kongobujiArea = Area(
    latitude: 34.21412606524347,
    longitude: 135.584203528666,
    identifier: "Kongōbuji Area",
    challenge: kukaiChallenge,
    isTargetZone: true,
    radius: 140
)

let reihokanArea = Area(
    latitude: 34.211302,
    longitude: 135.58114351464857,
    identifier: "Reihōkan Museum Area",
    challenge: kukaiChallenge,
    isTargetZone: true,
    radius: 100
)

let tokugawaArea = Area(
    latitude: 34.21738288146782,
    longitude: 135.58311965014107,
    identifier: "Tokugawa Family Mausoleum Area",
    challenge: shogunsChallenge,
    isTargetZone: true,
    radius: 90
)

let nyonindoArea = Area(
    latitude: 34.22014568888712,
    longitude: 135.5806889392046,
    identifier: "Nyonindō Area",
    challenge: nyonindoChallenge,
    isTargetZone: true,
    radius: 110
)

let choishiTenArea = Area(
    latitude: 34.212838383,
    longitude: 135.58969,
    identifier: "Choishi Number 10",
    challenge: choishiChallenge,
    isTargetZone: true,
    radius: 100
)

let sammaiinArea = Area(
    latitude: 34.20970989236701,
    longitude: 135.5872414883954,
    identifier: "Sammai-in Area",
    challenge: koyakunChallenge,
    isTargetZone: true,
    radius: 300
)

let karukayadoArea = Area(
    latitude: 34.21204613313004,
    longitude: 135.59280684389128,
    identifier: "Karukayadō Area",
    challenge: nil,
    isTargetZone: false,
    radius: 100
)

let ichinohashiArea = Area(
    latitude: 34.2139808933435,
    longitude: 135.5958476739542,
    identifier: "Ichi-no-Hashi Area",
    challenge: gorintoChallenge,
    isTargetZone: true,
    radius: 100
)

let kenshinArea = Area(
//    latitude: 34.217022502342516,
//    longitude: 135.5983387334238,
    latitude: 34.21702248,
    longitude: 135.598298,
    identifier: "Uesugi Kenshin Mausoleum Area",
    challenge: kenshinChallenge,
    isTargetZone: true,
    radius: 70
)

let nakanohashiArea = Area(
    latitude: 34.218245425673395,
    longitude: 135.6020572196682,
    identifier: "Naka-no-hashi Area",
    challenge: koyakunChallenge, // first
    isTargetZone: true,
    radius: 125
)

let bashoArea = Area(
    latitude: 34.21988395573015,
    longitude: 135.60467022732885,
    identifier: "Bashō-Kessho Jizō Area",
    challenge: shogunsChallenge,
    isTargetZone: true,
    radius: 90
)

let tamagawaArea = Area(
    latitude: 34.22191,
    longitude: 135.60592,
    identifier: "Tamagawa Area",
    challenge: mizumukeChallenge,
    isTargetZone: true,
    radius: 90
)

let torodoArea = Area(
    latitude: 34.22312,
    longitude: 135.60576973055655,
    identifier: "Tōrōdō Area",
    challenge: nil,
    isTargetZone: false,
    radius: 105
)

let nakanohashiParkingArea = Area(
    latitude: 34.21605616024564,
    longitude: 135.60445876968933,
    identifier: "Naka-no-hashi Parking",
    challenge: numbersChallenge,
    isTargetZone: true,
    radius: 110
)

var areas: [Area] = [
    daimonArea,
    eastGaranArea,
    westGaranArea,
    reihokanArea,
    kongobujiArea,
    tokugawaArea,
    nyonindoArea,
    choishiTenArea,
    sammaiinArea,
    karukayadoArea,
    ichinohashiArea,
    kenshinArea,
    nakanohashiArea,
    bashoArea,
    tamagawaArea,
    torodoArea,
    nakanohashiParkingArea
]
