//
//  Information.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/21.
//

import SwiftUI

struct InfoBodyText: Hashable, Codable {
    var headerOne:  String
    var bodyOne:    String
    var headerTwo:  String
    var bodyTwo:    String
}

struct Information: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var body: InfoBodyText
    
    
    static let allInfo = Bundle.main.decode([Information].self, from: "Information.json")
}

struct InformationResponse : Decodable {
    let request: [Information]
}
