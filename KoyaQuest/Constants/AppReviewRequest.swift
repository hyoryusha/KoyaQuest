//
//  AppReviewRequest.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2022/06/26.
//

import SwiftUI
import StoreKit

enum AppReviewRequest {
    static var threshold = 1 // this will request the review only one time per new version
    @AppStorage("runsSinceLastRequest") static var runsSinceLastRequest = 0
    @AppStorage("version") static var version = ""

    static func requestReviewIfNeeded() {
        runsSinceLastRequest += 1
        let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let thisVersion = "Version: \(appVersion) Build: \(appBuild)"

        if thisVersion != version {
            if runsSinceLastRequest == threshold {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
                version = thisVersion
                //runsSinceLastRequest = 0 // this should be activated if a different threshold is used
                }
            }
        } else {
            runsSinceLastRequest = 0 // reset if a new version is detected
        }
    }
}
