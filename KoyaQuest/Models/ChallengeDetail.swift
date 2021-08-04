//
//  ChallengeDetail.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/03.
//

import SwiftUI

struct ChallengeDetail: Hashable, Codable, Identifiable {

    var id: Int
    var header: String
    var teaser: String
    var synopsis: String
    var instructions: String
    var extra: String
    var imageName: String
    var image: Image {
        Image(imageName)
    }

    static let allDescriptions = Bundle.main.decode([ChallengeDetail].self, from: "ChallengeDetails.json")

    static let example = allDescriptions[0]
    static let koyakunChallengeDetails = allDescriptions.filter { $0.id == 1 }.first
    static let daimonChallengeDetails = allDescriptions.filter { $0.id == 2 }.first
    static let choishiChallengeDetails = allDescriptions.filter { $0.id == 3 }.first
    static let vajraChallengeDetails = allDescriptions.filter { $0.id == 4 }.first
    static let saigyoChallengeDetails = allDescriptions.filter { $0.id == 5 }.first
    static let gorintoChallengeDetails = allDescriptions.filter { $0.id == 6 }.first
    static let kenshinChallengeDetails = allDescriptions.filter { $0.id == 7 }.first
    static let mizumukeChallengeDetails = allDescriptions.filter { $0.id == 8 }.first
    static let kukaiChallengeDetails = allDescriptions.filter { $0.id == 9 }.first
    static let nyonindoChallengeDetails = allDescriptions.filter { $0.id == 10 }.first
    static let numbersChallengeDetails = allDescriptions.filter { $0.id == 11 }.first
    static let shogunChallengeDetails = allDescriptions.filter { $0.id == 12 }.first
}
