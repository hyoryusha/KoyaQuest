//
//  Share.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2022/05/11.

import Foundation
import SwiftUI

struct Share: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    var imageToShare: UIImage?
    //var activityItems: [Any]
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil


    func makeUIViewController(context: Context) -> UIActivityViewController {
//        let items: [Any] = ["Check Out my Score", UIImage(named: "Image")!]
        let items: [Any] = [imageToShare as Any, "Check Out my Score", URL(string: "https://www.koyaquest.com/leaderboard.php")!]
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
    
}


