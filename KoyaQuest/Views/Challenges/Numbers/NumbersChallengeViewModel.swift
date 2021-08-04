//
//  NumbersChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SwiftUI

class NumbersChallengeViewModel: ObservableObject {
    @Published var complete: Bool = false
    @Published var points: Int = 0
}
