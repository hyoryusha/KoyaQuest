//
//  BonusQuestionViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/18.
//

import SwiftUI

final class BonusQuestionViewModel: ObservableObject {
    @Published var count = 0
    @Published var points = 0

    func calculateScore() {
        switch self.count {
        case 0:
            self.points = 12
        case 1:
            self.points = 8
        case 2:
            self.points = 4
        case 3:
            self.points = 2
        default:
            self.points = 0
        }
    }
}
