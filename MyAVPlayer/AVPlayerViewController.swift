//
//  AVPlayerViewController.swift
//  AVPlayer
//
//  Created by knax on 11/1/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import Photos

class AVPlayerViewController: UIViewController {
    
    //create the video asset property
    var videoToPlay: AVAsset?
    
    
    
    
    @IBAction func getVideo(_ sender: Any) {
        //check if authorization is given to access user lib
        PHPhotoLibrary.requestAuthorization({(status: PHAuthorizationStatus)-> Void in
            
            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
                self.startImagePickerFromVC(self, usingDelegate: self)
            } else {
                let alert = UIAlertController(title: "Unauthorized", message: "user authorization required for action", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    
    @IBAction func playVideo(_ sender: Any) {
    }
    
    func startImagePickerFromVC(_ viewController: UIViewController!, usingDelegate delegate: (UINavigationControllerDelegate & UIImagePickerControllerDelegate)!){
        //check source for availablity
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            let alert = UIAlertController(title: "Source not available", message: "album not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true, completion:  nil)
            
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.delegate = delegate
        present(imagePicker,animated: true, completion: nil)
    }
}

extension AVPlayerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType == kUTTypeMovie {
            let avAsset = AVAsset(url: info[UIImagePickerControllerMediaURL] as! URL)
            let message = "Done"
            
            print("----------------------")
            print("avAsset", avAsset)
            print("----------------------")
            
            dismiss(animated: true, completion:  nil)
            let alert = UIAlertController(title: "Asset Loaded", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true,completion: nil)
            let alert = UIAlertController(title: "Error", message: "asset not loaded", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
        }
    }
}

extension AVPlayerViewController: UINavigationControllerDelegate {
    
}




