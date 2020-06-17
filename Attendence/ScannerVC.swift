import AVFoundation
import UIKit
import FirebaseDatabase
class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        start()
    }
    func start(){
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
          videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
          return
        }

        if (captureSession.canAddInput(videoInput)) {
          captureSession.addInput(videoInput)
        } else {
          failed()
          return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
          captureSession.addOutput(metadataOutput)

          metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
          metadataOutput.metadataObjectTypes = [.qr]
        } else {
          failed()
          return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        self.view.bringSubviewToFront(backButton)

    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

//        dismiss(animated: true)
    }

    func found(code: String) {
        print(code)
        let formattedString = code.replacingOccurrences(of: " ", with: "") // result: "HelloWorld!"
        let array = formattedString.components(separatedBy: ":")
        let uid = array[0]
        var ref: DatabaseReference! = Database.database().reference()

        var dataDictionary: [String: Any] = [:]
        dataDictionary["attendance"] = constantVal.allUsers[constantVal.currentUID]!.attendance!+1
        constantVal.allUsers[constantVal.currentUID]!.addAttendance()
        ref.child("Members").child(uid).updateChildValues(dataDictionary)
    
        start()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func goBack(_ sender: Any) { dismiss(animated: true, completion: nil) }
    
}
