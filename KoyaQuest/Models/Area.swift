//
//  Area.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/15.
//

import SwiftUI
import CoreLocation
import MapKit

class Area : NSObject, Identifiable , ObservableObject{
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
    
    init(latitude: Double, longitude: Double, identifier: String,   challenge: Challenge?, isTargetZone: Bool,  radius: CLLocationDistance ){
        self.identifier = identifier
        self.challenge = challenge
        self.isTargetZone = isTargetZone
        self.radius = radius
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static let greaterArea = Area(
    latitude: 34.2109456915934,
    longitude: 135.59842651113263,
    identifier: "Mount Kōya",
    challenge: nil,
    isTargetZone: false,
    radius: 5000) //this will be the all-encompassing area
}
    //FOR TESTING USE:
//    static let greaterArea = Area(
//    latitude: 34.227986163306326,
//    longitude: 135.17241732324624,
//    identifier: "Greater Wakayama Area",
//    challenge: nil,
//    isTargetZone: false,
//    radius: 5000) //this will be the all-encompassing area
//}

//MARK: - Area Extension
extension Area : MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return location.coordinate
        }
    }
    
    var title: String? { //optional
        get {
            return identifier
        }
    }
}


//MARK: =REAL COORDS
//34.21316180316554, 135.57287620970556,

let daimonArea = Area(
    latitude: 34.21316180316554,
    longitude: 135.57287620970556,
    identifier: "Daimon Area",
    challenge: daimonChallenge,
    isTargetZone: true,
    radius: 200
 )

let westGaranArea = Area( // ctr = Just in front of Sannō-in 34.213159852451895, 135.5788178525504
    latitude: 34.21405673565949, //34.21405673565949, 135.57831499579422 // NE CORNER (near stump)
    longitude: 135.57831499579422,
    identifier: "West Garan Area",
    challenge: vajraChallenge,
    isTargetZone: true,
    radius: 150
)
//new coords: 34.212170098448745, 135.58202912618154 closer to street near Daishokai
// or: 34.21283234018334, 135.5814981828189 (using 120 meter radius)
let eastGaranArea = Area( // ctr = Fudōdō
    latitude:  34.212826723404326, //34.212826723404326, 135.5813824754775
    longitude: 135.5813824754775,
    identifier: "East Garan Area",
    challenge: saigyoChallenge,
    isTargetZone: true,
    radius: 110
)

//34.21412606524347, 135.584203528666
//new coords with 200 meter radius: 34.214349904925164, 135.5842985055192 
let kongobujiArea = Area( //ctr = slightly to east of Seimon 34.21362538275349, 135.58369070223387
    latitude: 34.21412606524347, //34.21412606524347,135.584203528666
    longitude: 135.584203528666,
    identifier: "Kongōbuji Area",
    challenge: kukaiChallenge,
    isTargetZone: true,
    radius: 140
)
//34.21701697334374,135.58236903943072
let tokugawaArea = Area(// ctr = mid driveway to Tokugawa Mausoleum 34.21701697334374, 135.58236903943072
    latitude: 34.21738288146782, //34.21738288146782, 135.58311965014107
    longitude: 135.58311965014107,
    identifier: "Tokugawa Family Mausoleum Area",
    challenge: shogunsChallenge,
    isTargetZone: false,
    radius: 80
)
//34.22014568888712, 135.5806889392046 nyonindo parking
let nyonindoArea = Area(
    latitude: 34.22014568888712, //34.220863576476596, 135.58003787657387 // a little to the NE
    longitude: 135.5806889392046,
    identifier: "Nyonindō Area",
    challenge: nyonindoChallenge,
    isTargetZone: true,
    radius: 110
)

let sammaiinArea = Area(
    latitude: 34.20970989236701,
    longitude: 135.5872414883954,
    identifier: "Sammai-in Area",
    challenge: nil,
    isTargetZone: false,
    radius: 300
)


let karukayadoArea = Area( //34.212718947198184, 135.59291758009476
    latitude: 34.21204613313004, //34.21204613313004, 135.59280684389128
    longitude: 135.59280684389128,
    identifier: "Karykayadō Area",
    challenge: nil,
    isTargetZone: false,
    radius: 200
)
//34.21475754155296, 135.59571409387402
let ichinohashiArea = Area( // ctr just before Sakaguchi monument 34.2140573718463, 135.59612207197912
    latitude: 34.21475754155296, //34.214477282121486, 135.59704793229997 // a little further along the path
    longitude: 135.59571409387402, // in woods to north
    identifier: "Ichi-no-Hashi Area",
    challenge: gorintoChallenge,
    isTargetZone: true,
    radius: 120
 )

//34.21330357904938,  135.5855224562209 // RENGE-IN/ CHOISHI NO. 6?


let kenshinArea = Area( // ctr = off the path to the left just before the mausoleum 34.21677400270375, 135.59849085192934;
    latitude: 34.21795458937127, // well behind the mausolem: 34.21795458937127, 135.59820076202416
    longitude: 135.59820076202416,
    identifier: "Uesugi Kenshin Mausoleum Area",
    challenge: kenshinChallenge,
    isTargetZone: true,
    radius: 170
)
//34.218245425673395, 135.6020572196682
let nakanohashiArea = Area(
    latitude: 34.218245425673395, //34.218911914896886, 135.60205816716297 again well behind the asekaki jizo
    longitude: 135.6020572196682,
    identifier: "Naka-no-hashi Area",
    challenge: koyakunChallenge,
    isTargetZone: true,
    radius: 125
)
//34.21930414162038, 135.60506125924698, 34.21988395573015, 135.60467022732885
let bashoArea = Area(
    latitude: 34.21988395573015,
    longitude: 135.60467022732885,
    identifier: "Bashō-Kessho Jizō Area",
    challenge: nil, //Maybe add challenge here?
    isTargetZone: false,
    radius: 130
)



//HIDEYOSHI Lat: 34.2206914304143 , 135.6054891554039
//34.22133507975566, 135.60677547761603
let tamagawaArea = Area( // ctr = on the path near Oda Nobunaga haka 34.22142514595214, 135.6057321981955
    latitude: 34.22133507975566, // 34.22026470325749, 135.60563840520004 where the path forks?
    longitude: 135.60677547761603,
    identifier: "Tamagawa Area",
    challenge: mizumukeChallenge,
    isTargetZone: true,
    radius: 130
)

let torodoArea = Area( //34.22302007929656, 135.60576679271776
    latitude: 34.22354443963421, // behind gobyo 34.22354443963421, 135.60576973055655
    longitude: 135.60576973055655,
    identifier: "Tōrōdō Area",
    challenge: nil,
    isTargetZone: false,
    radius: 100
)
//34.21605616024564, 135.60445876968933

let nakanohashiParkingArea = Area(
    latitude: 34.21605616024564,
    longitude: 135.60445876968933,
    identifier: "Naka-no-hashi Parking",
    challenge: numbersChallenge,
    isTargetZone: true,
    radius: 130
)


var areas: [Area] = [
    daimonArea,
    eastGaranArea,
    westGaranArea,
    kongobujiArea,
    tokugawaArea,
    nyonindoArea,
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

/*
//MOCK COORDINATES

let daimonArea = Area( //using Shieki ,
    latitude: 34.236134334822445,
    longitude: 135.1670582073104,
    identifier: "Daimon Area",
    challenge: daimonChallenge,
    isTargetZone: true,
    radius: 100
 )

let westGaranArea = Area( // Using Intersection at Saginomori ,
    latitude: 34.23570028061141,
    longitude: 135.17159541225104,
    identifier: "West Garan Area",
    challenge: numbersChallenge,
    isTargetZone: true,
    radius: 100
)

let eastGaranArea = Area( // USING SMALL BRIDGE near home
    latitude:  34.23273578201945,
    longitude: 135.17163990045452,
    identifier: "East Garan Area",
    challenge: koyakunChallenge,
    isTargetZone: true,
    radius: 100
)


let kongobujiArea = Area( //USING MOMIJIDANI
    latitude: 34.228829546303864,
    longitude: 135.17026966414898,
    identifier: "Kongōbuji Area",
    challenge: kukaiChallenge,
    isTargetZone: true,
    radius: 100
)

let tokugawaArea = Area( //SKIP
    latitude: 34.21738288146782, //34.21738288146782, 135.58311965014107
    longitude: 135.58311965014107,
    identifier: "Tokugawa Family Mausoleum Area",
    challenge: nil,
    isTargetZone: false,
    radius: 100
)

let nyonindoArea = Area( // USING KITA BURAKURICHO
    
    latitude: 34.23500017016528,
    longitude: 135.17448388167134,
    identifier: "Nyonindō Area",
    challenge: vajraChallenge,
    isTargetZone: true,
    radius: 100
)

let sammaiinArea = Area( //SKIP
    latitude: 34.20970989236701,
    longitude: 135.5872414883954,
    identifier: "Sammai-in Area",
    challenge: nil,
    isTargetZone: false,
    radius: 200
)


let karukayadoArea = Area( //SKIP
    latitude: 34.21204613313004, //34.21204613313004, 135.59280684389128
    longitude: 135.59280684389128,
    identifier: "Karykayadō Area",
    challenge: nil,
    isTargetZone: false,
    radius: 100
)

let ichinohashiArea = Area( // USING 7-11 at Yakatamachi and Keyaki intersection
    latitude: 34.23023130544129,
    longitude: 135.17829784176902,
    identifier: "Ichi-no-Hashi Area",
    challenge: gorintoChallenge, //???
    isTargetZone: true,
    radius: 100
 )



let kenshinArea = Area( // Horizumebashi
    latitude: 34.23252992705587,
    longitude: 135.17703076700369,
    identifier: "Uesugi Kenshin Mausoleum Area",
    challenge: kenshinChallenge,
    isTargetZone: true,
    radius: 200
)

let nakanohashiArea = Area( //USING Intersection North of DonQuixote
    latitude: 34.23507522013451,
    longitude: 135.17706218208158,
    identifier: "Nakanohashi Area",
    challenge: sugatamiChallenge,
    isTargetZone: true,
    radius: 100
)
//34.21930414162038, 135.60506125924698,
let bashoArea = Area( // SKIP
    latitude: 34.21930414162038,
    longitude: 135.60506125924698,
    identifier: "Bashō-Kesshojizō Area",
    challenge: nil, //Maybe add challenge here?
    isTargetZone: false,
    radius: 100
)

let tamagawaArea = Area( // CASTLE OKA PARK ENTRANCE
    latitude: 34.22646806169496,
    longitude: 135.17457612124287,
    identifier: "Tamagawa Area",
    challenge: mizumukeChallenge,
    isTargetZone: true,
    radius: 100
)

let torodoArea = Area( //SKIP
    latitude: 34.22354443963421, // behind gobyo 34.22354443963421, 135.60576973055655
    longitude: 135.60576973055655,
    identifier: "Tōrōdō Area",
    challenge: nil,
    isTargetZone: false,
    radius: 100
)

var areas: [Area] = [
    daimonArea,
    eastGaranArea,
    westGaranArea,
    kongobujiArea,
    //tokugawaArea,
    nyonindoArea,
    //sammaiinArea,
    //karukayadoArea,
    ichinohashiArea,
    kenshinArea,
    nakanohashiArea,
   // bashoArea,
    tamagawaArea,
    //torodoArea
]

*/
