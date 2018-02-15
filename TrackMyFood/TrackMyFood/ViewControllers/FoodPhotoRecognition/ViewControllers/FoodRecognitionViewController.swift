//
//  FoodRecognitionViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
import SwiftSpinner

class FoodRecognitionViewController: UIViewController, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate, PhotoRecognitionViewModelDelegate {
    
    @IBOutlet weak var infoMessage: UILabel!
    var viewModel: PhotoRecognitionViewModel = PhotoRecognitionViewModel()
    var imagePicker: UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initView()
    }
    
    private func initView() {
        self.navigationController?.navigationBar.topItem?.title = viewModel.screenTitle
        self.infoMessage.attributedText = viewModel.infoMessage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imagePicker.cameraCaptureMode = .photo
            present(self.imagePicker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func proccessImage(image: UIImage) {
        SwiftSpinner.show("Processing the image...").addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: "Tap to hide while processing! This will affect the current operation.")
        self.viewModel.processImage(image: image)
    }
    
    // MARK: - Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        //imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.proccessImage(image: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func navigateToFoodDetailsScreen() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FoodDetails") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Action
    
    @IBAction func takeAPhotoClicked(_ sender: Any) {
        self.openCamera()
    }
    
    // MARK: - Photo Recognition View Model Delegate
    
    func updateUI() {
        SwiftSpinner.show("Processing Finished.", animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            SwiftSpinner.hide()
            self.navigateToFoodDetailsScreen()
        })
    }
    
}
