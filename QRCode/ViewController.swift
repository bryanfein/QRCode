//
//  ViewController.swift
//  QRCode
//
//  Created by Bryan Fein on 5/18/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Variables
    var qrCodeImage: CIImage!
    
    
    //Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnAction: UIButton!
    
    
    override func viewDidLoad() {
        
        
    }
    
    
    func displayQRCodeImage(){
        
        let scaleX = imgQRCode.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrCodeImage.extent.size.width

        let transformedImage = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let scaled = qrCodeImage.applying(transformedImage)
        
        imgQRCode.image = UIImage(ciImage: scaled)
        

        
    }
    
    @IBAction func generateButton(_ sender: UIButton) {
        if qrCodeImage == nil {
            
            
            //nothing will happen is textfield is empty
            if textField.text == "" {
                return
            }
            
            let data = textField.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrCodeImage = filter?.outputImage
            
            //convert the output CIImage to an UIImage object
//            imgQRCode.image = UIImage(ciImage: qrCodeImage)
            displayQRCodeImage()
            
            textField.resignFirstResponder()
            
            btnAction.setTitle("Clear", for: .normal)
            slider.isHidden = false
            
        }
        else {
            imgQRCode.image = nil
            qrCodeImage = nil
            btnAction.setTitle("Generate", for: .normal)
            
        }
//        
//        textField.isEnabled = !textField.isEnabled
//        slider.isHidden = !slider.isHidden
        
    }
    
    @IBAction func changeImageViewScale(_ sender: UISlider) {
        
//        imgQRCode.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
//        slider.isHidden = false
//        
    }
}

