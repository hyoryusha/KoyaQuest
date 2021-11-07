//
//  NyonindoChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/10.
//

import SwiftUI

class NyonindoChallengeViewModel: ObservableObject {
//    @Published var gameActive: Bool = false
//    @Published var attempts: Int = 0
//    @Published var recentScore: Int = 0
//    @Published var highestScore: Int = 0
//
//    var completed: Bool {
//        attempts >= 3 ? true : false
//    }

    @Published var attempts: Int = 0
    @Published var recentScore: Int = 0
    @Published var highestScore: Int = 0
    @Published var gameOver: Bool = false

}
