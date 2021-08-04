//
//  TakedaScannerVC.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import UIKit
import AVFoundation

enum CameraError {
    case invalidDeviceInput
    case invalidScannedValue
    case invalidFirstObject
}

enum KoyaLocation: String {

    case takedaGrave = "Takeda Shingen's Grave"
    case unknown = "Unrecognized QR Code"
    case excluded = "QR-Code does not belong to Mt. Koya"
}

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didSurface(error: CameraError)
    func didMatchLocation(barcode: String)
}

final class ScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?

    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }

    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        let videoInput: AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        let metaDataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.qr] // ean8 , .ean13 // qr for Koyasan
        } else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill // force unwrap okay
        view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
}
extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            // scannerDelegate?.didSurface(error: .invalidFirstObject)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        // scannerDelegate?.SOMETHING
        scannerDelegate?.didMatchLocation(barcode: barcode)
        scannerDelegate?.didFind(barcode: barcode) // this, finally, sends the found barcode string to the delegate
        // captureSession.stopRunning() // this can be called after one barcode is found
    }
}
