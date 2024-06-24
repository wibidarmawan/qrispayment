//
//  QRISViewController.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit
import AVFoundation

class QRISViewController: UIViewController {
    
    private let container = UIView()
    
    private lazy var closeButton = {
        let button = UIButton()
        button.setImage(.close, withTintColor: .primary, states: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    
    var presenter: QRISPresenterProtocol?
    private var session: AVCaptureSession! = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var isScanning = false
    
    override func viewDidLoad() {
        baseConfigure()
        setupConstraints()
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (session?.isRunning == false) {
            startSession()
            isScanning = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }
    
    private func baseConfigure() {
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        view.addSubviews(container, closeButton)
        container.backgroundColor = .black
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacing.xl + AppInfo.topSafeAreaInsets)
            make.trailing.equalToSuperview().inset(Spacing.xl)
            make.width.height.equalTo(30)
        }
        
        
    }
    
    private func setupCamera() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        container.layer.addSublayer(previewLayer)
        
        startSession()
    }
    
    private func startSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.startRunning()
        }
    }

    private func failed() {
        let alertController = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        session = nil
    }
    
    @objc
    private func didTapCloseButton() {
        self.dismiss(animated: true)
    }
    
}

extension QRISViewController: QRISViewProtocol {
    
    func showTransactionDetail(_ qrisModel: QRISModel) {
        presenter?.showTransactionDetail(qrisModel)
    }
    
    func showError(_ message: String) {
        self.view.showToast(message: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.startSession()
            self?.isScanning = false
        })
    }
    
}

extension QRISViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        if isScanning { return }
        
        session.stopRunning()
        isScanning = true
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            presenter?.validateQRISString(stringValue)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
