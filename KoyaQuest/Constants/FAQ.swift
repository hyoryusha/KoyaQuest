//
//  FAQ.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/24.
//

import SwiftUI

struct FAQBodyText: Hashable, Codable {
    var headerOne: String
    var bodyOne: String
}

enum FAQCategory: String, CaseIterable, Codable {
    case places = "Places"
    case people = "People"
    case buddhism = "Buddhism"
    case customs = "Customs & Practices"
}

struct FAQ: Hashable, Codable, Identifiable {
    var id: Int
    var filter: String
    var category: FAQCategory
    var title: String
    var body: FAQBodyText
    static let allFAQ = Bundle.main.decode([FAQ].self, from: "FAQ.json")
    static let allCats = [FAQCategory.places,
                          FAQCategory.people,
                          FAQCategory.buddhism,
                          FAQCategory.customs]
}

struct FAQResponse: Decodable {
    let request: [FAQ]
}
