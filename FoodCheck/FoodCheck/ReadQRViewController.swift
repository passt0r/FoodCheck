//
//  ReadQRViewController.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 21.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation
import os.log

class ReadQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //MARK: - Outlets
    @IBOutlet private weak var addFood: UIButton!
    @IBOutlet weak var readerStatusLabel: UILabel!
    // @IBOutlet weak var qrReaderView: UIView! does not work in this way, download after main view controler
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    var capturedSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]
    
    var capturedFoodItem: FoodItemInFridge?
    
    var wasAdded = false //because segue was added things multiple times
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding background image to view
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "fridge_back"))
        backgroundImage.frame = UIScreen.main.bounds
        view.insertSubview(backgroundImage, at: 0)
        view.clipsToBounds = true
        errorLabel.layer.masksToBounds = true
        errorLabel.layer.cornerRadius = 10
        errorLabel.isHidden  = true
        readerStatusLabel.layer.masksToBounds = true
        readerStatusLabel.layer.cornerRadius = 10
        readerStatusLabel.isHidden = false
        
        wasAdded = false //this is for debug of capturing data
        
        setupButton()
        prepareCaptureDevice()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prepareCaptureDevice() {
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // Initialize the captureSession object.
            let captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession.addInput(input)
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the qrCodeFrameView view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            //guard let qrFrame = qrCodeFrameView else {fatalError()}
            videoPreviewLayer?.frame = self.view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession.startRunning()
            
            view.bringSubview(toFront: readerStatusLabel)
            view.bringSubview(toFront: addFood)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            print(error)
            errorLabel.isHidden = false
            readerStatusLabel.isHidden = true
            return
            
        }
    }

    
    func setupButton() {
        addFood.layer.cornerRadius = 10
        addFood.clipsToBounds = true
        addFood.backgroundColor = UIColor.white
    }
    
    
    @IBAction func cancelAdding(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Need for search food with corresponding code in base
    func findCorrespondingFoodInBase(withCode code: String) -> FoodItemInFridge? {
        
        let baseWithItems = try! Realm(configuration: getReleaseDB())
        var predicate = NSPredicate(format: "qrCode == %@", code)
        var searchResult = baseWithItems.objects(FoodItem.self).filter(predicate)
        
        if searchResult.isEmpty {
            predicate = NSPredicate(format: "barcode == %@", code)
            searchResult = baseWithItems.objects(FoodItem.self).filter(predicate)
            
            if searchResult.isEmpty {
                return nil
            } else {
                let foodToFridge = preparedForFridge(food: searchResult[0])
                return foodToFridge
                }

        } else {
            let foodToFridge = preparedForFridge(food: searchResult[0])
            return foodToFridge
            }
    
    }
    
    //MARK: - AVCaptureMetadataOutputObjectsDelegate protocol implementation
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            readerStatusLabel.text = "Scanning..."
            return
        }
        // Get the metadata object.
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if supportedCodeTypes.contains(metadataObject.type)  {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObject.stringValue != nil {
                readerStatusLabel.text = "Scaned"
                //MARK: For this searching for food in dataBase you must first add information about codes in dataBase
                //capturedFoodItem = findCorrespondingFoodInBase(withCode: metadataObject.stringValue)

                //MARK: - This is for sampla
                let foodItem = FoodItem()
                foodItem.name = "Milk"
                foodItem.shelfLife = 432000
                foodItem.chooseType(ofType: .milk)
                foodItem.chooseLogo(ofType: .milk)
                capturedFoodItem = preparedForFridge(food: foodItem)
                if wasAdded == false {
                    self.performSegue(withIdentifier: "qrReader", sender: self)
                    wasAdded = !wasAdded
                }
            }
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*
        if segue.identifier == "qrReader" {
            let dataBase = try! Realm()
            if let capturedFoodItem = capturedFoodItem {
                try! dataBase.write {
                    dataBase.add(capturedFoodItem)
                }
            } else {
                os_log("qrReader segue was detected, but CapturedFoodItem was nil", log: .default, type: .error)
            }
            
        }
        */
        
        
    }
    

}
