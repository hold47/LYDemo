//
//  QRCodeScannerController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import AVFoundation
import CoreGraphics
import SafariServices
import UIKit

public class QRCodeScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var squareView: SquareView?
    var cameraButton: UIButton = UIButton()
    // Default Properties
    let bottomSpace: CGFloat = 0.0
    var devicePosition: AVCaptureDevice.Position = .back
    open var qrScannerFrame: CGRect = CGRect.zero
    
    var cancelButton = UIButton(text: "关闭", textColor: Constant.mainColor, font: UIFont.systemFont(ofSize: 16))
    var disposeBag = DisposeBag()

    // Initialization part
    lazy var captureSession = AVCaptureSession()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScanningQRCode()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopScanningQRCode()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "扫描二维码"
        modalPresentationStyle = .fullScreen
        let barItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(QRCodeScannerController.dismissVC))
        navigationItem.leftBarButtonItem = barItem
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.top.equalTo(Constant.statusBar_height + 10)
        }
        cancelButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismissVC()
        }).disposed(by: disposeBag)
        
        prepareQRScannerView(view)
    }

    /// Lazy initialization of properties
    lazy var defaultDevice: AVCaptureDevice? = {
        if let device = AVCaptureDevice.default(for: .video) {
            return device
        }

        return nil
    }()

    lazy var frontDevice: AVCaptureDevice? = {
        if #available(iOS 10, *) {
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                return device
            }
        } else {
            for device in AVCaptureDevice.devices(for: .video) {
                if device.position == .front {
                    return device
                }
            }
        }
        return nil
    }()

    lazy var defaultCaptureInput: AVCaptureInput? = {
        if let captureDevice = defaultDevice {
            do {
                return try AVCaptureDeviceInput(device: captureDevice)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }()

    lazy var frontCaptureInput: AVCaptureInput? = {
        if let captureDevice = frontDevice {
            do {
                return try AVCaptureDeviceInput(device: captureDevice)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }()

    lazy var dataOutput = AVCaptureMetadataOutput()

    lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return layer
    }()

    open func prepareQRScannerView(_ view: UIView) {
        qrScannerFrame = view.frame
        setupCaptureSession(devicePosition) // Default device capture position is back
        addViedoPreviewLayer(view)
        createCornerFrame()
    }

    private func createCornerFrame() {
        let width: CGFloat = 200
        let height: CGFloat = 200
        let rect = CGRect(origin: CGPoint(x: view.frame.width / 2 - width / 2, y: view.frame.height / 2 - (width + bottomSpace) / 2), size: CGSize(width: width, height: height))
        squareView = SquareView(frame: rect)
        if let squareView = squareView {
            view.addSubview(squareView)
        }
    }

    // Toggle torch
    @objc func toggleTorch() {
        // If device postion is front then no need to torch
        if let currentInput = getCurrentInput() {
            if currentInput.device.position == .front {
                return
            }
        }

        guard let defaultDevice = defaultDevice else { return }
        if defaultDevice.isTorchAvailable {
            do {
                try defaultDevice.lockForConfiguration()
                defaultDevice.torchMode = defaultDevice.torchMode == .on ? .off : .on
                cameraButton.setImage(defaultDevice.torchMode == .on ? UIImage(named: "flash") : UIImage(named: "flass-off"), for: .normal)
                defaultDevice.unlockForConfiguration()
            } catch let error as NSError {
                print(error)
            }
        }
    }

    // Switch camera
    @objc func switchCamera() {
        if let frontDeviceInput = frontCaptureInput {
            captureSession.beginConfiguration()
            if let currentInput = getCurrentInput() {
                captureSession.removeInput(currentInput)
                let newDeviceInput = (currentInput.device.position == .front) ? defaultCaptureInput : frontDeviceInput
                captureSession.addInput(newDeviceInput!)
            }
            captureSession.commitConfiguration()
        }
    }

    private func getCurrentInput() -> AVCaptureDeviceInput? {
        if let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput {
            return currentInput
        }
        return nil
    }

    // dismiss ViewController
    @objc func dismissVC() {
        removeVideoPriviewlayer()
        dismiss(animated: true, completion: nil)
    }

    open func startScanningQRCode() {
        if captureSession.isRunning {
            return
        }
        captureSession.startRunning()
    }

    open func stopScanningQRCode() {
        if !captureSession.isRunning {
            return
        }
        captureSession.stopRunning()
    }

    private func setupCaptureSession(_ devicePostion: AVCaptureDevice.Position) {
        if captureSession.isRunning {
            return
        }

        switch devicePosition {
        case .front:
            if let frontDeviceInput = frontCaptureInput {
                if !captureSession.canAddInput(frontDeviceInput) {
                    return
                }
                captureSession.addInput(frontDeviceInput)
            }
            break
        case .back, .unspecified:
            if let defaultDeviceInput = defaultCaptureInput {
                if !captureSession.canAddInput(defaultDeviceInput) {
                    return
                }
                captureSession.addInput(defaultDeviceInput)
            }
            break

        @unknown default:
            break
        }

        if !captureSession.canAddOutput(dataOutput) {
            return
        }

        captureSession.addOutput(dataOutput)
        dataOutput.metadataObjectTypes = dataOutput.availableMetadataObjectTypes
        dataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }

    private func addViedoPreviewLayer(_ view: UIView) {
        videoPreviewLayer.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.size.width, height: view.bounds.size.height - bottomSpace)
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
    }

    private func removeVideoPriviewlayer() {
        videoPreviewLayer.removeFromSuperlayer()
    }

    /// This method get called when Scanning gets complete
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for data in metadataObjects {
            let transformed = videoPreviewLayer.transformedMetadataObject(for: data) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                if unwraped.stringValue != nil {
                    found(result: unwraped.stringValue!)
                }
                stopScanningQRCode()
            }
        }
    }

    private func found(result: String) {
        print("检测到二维码:\(result)")
        if result.hasPrefix("http") {
            let alert = UIAlertController(title: "即将访问外部网站", message: result, preferredStyle: .alert)
            alert.addAction(title: "访问", style: .default, isEnabled: true) { _ in
                if let url = URL(string: result) {
                    let safariVC = SFSafariViewController(url: url)
                    self.present(safariVC, animated: true, completion: nil)
                }
            }
            alert.addAction(title: "取消", style: .cancel, isEnabled: true) { _ in
                self.startScanningQRCode()
            }
            present(alert, animated: true, completion: nil)
            return
        }

        let alert = UIAlertController(title: "二维码内容", message: result, preferredStyle: .alert)
        alert.addAction(title: "关闭", style: .default, isEnabled: true) { _ in
            self.startScanningQRCode()
        }
        present(alert, animated: true, completion: nil)
    }
}

/** This class is for draw corners of Square to show frame for scan QR code.
 *  @IBInspectable parameters are the line color, sizeMultiplier, line width.
 */
@IBDesignable
class SquareView: UIView {
    @IBInspectable
    var sizeMultiplier: CGFloat = 0.2 {
        didSet {
            draw(bounds)
        }
    }

    @IBInspectable
    var lineWidth: CGFloat = 2 {
        didSet {
            draw(bounds)
        }
    }

    @IBInspectable
    var lineColor: UIColor = Constant.mainColor {
        didSet {
            self.draw(self.bounds)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }

    func drawCorners() {
        let currentContext = UIGraphicsGetCurrentContext()

        currentContext?.setLineWidth(lineWidth)
        currentContext?.setStrokeColor(lineColor.cgColor)

        //top left corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: 0, y: 0))
        currentContext?.addLine(to: CGPoint(x: bounds.size.width * sizeMultiplier, y: 0))
        currentContext?.strokePath()

        //top rigth corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: bounds.size.width - bounds.size.width * sizeMultiplier, y: 0))
        currentContext?.addLine(to: CGPoint(x: bounds.size.width, y: 0))
        currentContext?.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height * sizeMultiplier))
        currentContext?.strokePath()

        // bottom rigth corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: bounds.size.width, y: bounds.size.height - bounds.size.height * sizeMultiplier))
        currentContext?.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        currentContext?.addLine(to: CGPoint(x: bounds.size.width - bounds.size.width * sizeMultiplier, y: bounds.size.height))
        currentContext?.strokePath()

        // bottom left corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: bounds.size.width * sizeMultiplier, y: bounds.size.height))
        currentContext?.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        currentContext?.addLine(to: CGPoint(x: 0, y: bounds.size.height - bounds.size.height * sizeMultiplier))
        currentContext?.strokePath()

        // second part of top left corner
        currentContext?.beginPath()
        currentContext?.move(to: CGPoint(x: 0, y: bounds.size.height * sizeMultiplier))
        currentContext?.addLine(to: CGPoint(x: 0, y: 0))
        currentContext?.strokePath()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCorners()
    }
}
