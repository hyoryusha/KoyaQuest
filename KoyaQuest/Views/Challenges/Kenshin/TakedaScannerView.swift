//
//  TakedaScannerView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI

struct TakedaScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem: KenshinScannerAlertItem?
    @Binding var foundLocation: String
    @Binding var success: Bool
    @Binding var foundTakeda: Bool

    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }

    final class Coordinator: NSObject, ScannerVCDelegate {
        private let scannerView: TakedaScannerView

        init(scannerView: TakedaScannerView) {
            self.scannerView = scannerView
        }

        func didFind(barcode: String) {
            //scannerView.scannedCode = barcode
        }

        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput: scannerView.alertItem = KenshinAlertContext.invalidDeviceInput
            case .invalidScannedValue: scannerView.alertItem = KenshinAlertContext.invalidScannedType
            case .invalidFirstObject: scannerView.alertItem = KenshinAlertContext.invalidFirstObject
            }
        }

        func didMatchLocation(barcode: String) {
            var locationIdentifier = String.SubSequence()
            var url = String.SubSequence()
            var location = KoyaLocation(rawValue: "")
            if let range = barcode.range(of: "=") {
                locationIdentifier = barcode[range.upperBound...]
                url = barcode[...range.lowerBound]
            }
            // make sure its a Koyasan QR code
            if url == "http://www.koyasan.net/i/map/index.php?place=" {
                switch locationIdentifier {
                case "28":
                    location = KoyaLocation.takedaGrave
                    scannerView.foundTakeda = true
                default:   scannerView.foundLocation = KoyaLocation.unknown.rawValue
                }
                scannerView.foundLocation = location?.rawValue ?? "You still haven't found it."
            } else {
                scannerView.foundLocation = KoyaLocation.excluded.rawValue
            }
        }
    }
}
