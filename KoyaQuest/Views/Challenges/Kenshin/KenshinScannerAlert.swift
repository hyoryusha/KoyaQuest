//
//  KenshinScannerAlert.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI
struct KenshinScannerAlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var dismissButton: Alert.Button
}

struct KenshinAlertContext {
    static let invalidDeviceInput = KenshinScannerAlertItem(
        title: "Invalid Input Device",
        message: "Something is wrong with the camera. Unable to scan.",
        dismissButton: .default(Text("OK"))
    )

    static let invalidScannedType = KenshinScannerAlertItem(
        title: "Invalid Scanned Type",
        message: "The value scanned is not valid. This app scans EAN-8 and EAN-13 barcodes only.",
        dismissButton: .default(Text("OK"))
    )

    static let invalidFirstObject = KenshinScannerAlertItem(
        title: "Invalid First Object?",
        message: "The value scanned is not the initial one, maybe. ",
        dismissButton: .default(Text("OK"))
    )
}
