//
//  NyonindoChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/10.
//

import SwiftUI

class NyonindoChallengeViewModel: ObservableObject {
    @Published var attempts: Int = 0
    @Published var recentScore: Int = 0
    @Published var highestScore: Int = 0
}
