//
//  DaimonGameViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/05.
//

import SwiftUI

final class DaimonGameViewModel: ObservableObject {

    @Published var showingAlert = false
    @Published var tapOnTarget = false
    @Published var respondToTap = true
    @Published var showingSolution = false
    @Published var isShowingModal = false
    @Published var points: Int = 0

}
