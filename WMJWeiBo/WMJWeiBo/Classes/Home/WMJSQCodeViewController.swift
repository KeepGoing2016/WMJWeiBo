//
//  WMJSQCodeViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/1.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit
import AVFoundation

class WMJSQCodeViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var codeLable: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var customBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customBar.selectedItem = customBar.items?.first
        customBar.delegate = self
        
        startSQCode()
    }
    
    override func viewWillAppear(animated: Bool) {
        startAnimation()
    }
    
    private func startSQCode(){
        if !session.canAddInput(input){
            return
        }
        
        if !session.canAddOutput(output){
            return
        }
        
        session.addInput(input)
        
        session.addOutput(output)
        
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        view.layer.insertSublayer(previewLayer, atIndex:0)
        previewLayer.frame = view.bounds
        
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
        WMJLog(UIScreen.mainScreen().bounds.width/2)
        session.startRunning()
    }

    private func startAnimation(){
        topConstraint.constant = -heightConstraint.constant
        view.layoutIfNeeded()
        UIView.animateWithDuration(2.0) { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.topConstraint.constant = self.heightConstraint.constant
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func intoPhotos(sender: AnyObject) {
//        WMJLog("进入相册")
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    private lazy var input:AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    
    private lazy var session:AVCaptureSession = AVCaptureSession()
    
    private lazy var output:AVCaptureMetadataOutput = {
        let avout = AVCaptureMetadataOutput()
        
        let viewRect = self.view.frame
        // 2.获取扫描容器的frame
        let containerRect = self.containerView.frame
        let x = containerRect.origin.y / viewRect.height;
        let y = containerRect.origin.x / viewRect.width;
        let width = containerRect.height / viewRect.height;
        let height = containerRect.width / viewRect.width;
        
//        avout.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        
        avout.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        
        return avout
    }()
    
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)

    private lazy var containerLayer:CALayer = CALayer()
}

extension WMJSQCodeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        
//    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let codeImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyLow])
        
       let results = detector.featuresInImage(CIImage(image: codeImage)!)
        
        for result in results{
            WMJLog((result as! CIQRCodeFeature).messageString)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension WMJSQCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        codeLable.text = metadataObjects.last?.stringValue
        
        clearLayers()
        
        guard let metadate = metadataObjects.last as? AVMetadataObject else{
            return
        }
        
        guard let objc = previewLayer.transformedMetadataObjectForMetadataObject(metadate) as?AVMetadataMachineReadableCodeObject else{
            return
        }
   
        drawLines(objc)
        WMJLog(metadataObjects.last)
    }
    
    private func drawLines(objc:AVMetadataMachineReadableCodeObject){
        guard let array = objc.corners else{
            return
        }
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.greenColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        let path = UIBezierPath()
        var point = CGPointZero
        var index = 0
        CGPointMakeWithDictionaryRepresentation((array[index++] as! CFDictionary), &point)
        path.moveToPoint(point)
        while index<array.count {
            CGPointMakeWithDictionaryRepresentation((array[index++] as! CFDictionary), &point)
            
            path.addLineToPoint(point)
        }
        
        path.closePath()
        layer.path = path.CGPath
        
        containerLayer.addSublayer(layer)
    }
    
    private func clearLayers(){
        guard let subLayers = containerLayer.sublayers else {
            return
        }
        
        for layer in subLayers{
            layer.removeFromSuperlayer()
        }
    }
}



extension WMJSQCodeViewController:UITabBarDelegate{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        heightConstraint.constant = item.title == "二维码" ? 250:150
        
//        view.layoutIfNeeded()
        
        view.layer.removeAllAnimations()
        
        startAnimation()
        
    }
}