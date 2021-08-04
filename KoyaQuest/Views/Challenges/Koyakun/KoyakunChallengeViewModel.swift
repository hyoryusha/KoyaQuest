//
//  KoyakunChallengeViewModel.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/01.
//

import SwiftUI

final class KoyakunChallengeViewModel: ObservableObject {
    @Published var completed = false
    @Published var timeLimit = 60
    @Published var points: Int = 0
}
