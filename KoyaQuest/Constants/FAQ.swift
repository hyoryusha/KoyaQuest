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

struct FAQ: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var body: FAQBodyText
    static let allFAQ = Bundle.main.decode([FAQ].self, from: "FAQ.json")
}

struct FAQResponse: Decodable {
    let request: [FAQ]
}
