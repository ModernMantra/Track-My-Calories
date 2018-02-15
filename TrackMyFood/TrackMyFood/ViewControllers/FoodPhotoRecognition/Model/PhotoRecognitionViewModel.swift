//
//  PhotoRecognitionViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
import CoreML

protocol PhotoRecognitionViewModelDelegate: class {
    func updateUI()
}
class PhotoRecognitionViewModel {
    
    weak var delegate: PhotoRecognitionViewModelDelegate?
    
    var screenTitle: String {
        get { return "Photo" }
    }
    
    private var processingImageHeight: CGFloat {
        get { return 299.0 }
    }
    
    private var processingImageWidth: CGFloat {
        get { return 299.0 }
    }
    
    var infoMessage: NSAttributedString {
        get {
            let paragraphsStyle = NSMutableParagraphStyle()
            paragraphsStyle.lineSpacing = 5.0
            paragraphsStyle.alignment = .center
            let boldAttribute = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 19)]
            let lightAttribute = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: .light)]
            let boldString = NSMutableAttributedString(string: "Discover Food Nutrition", attributes: boldAttribute)
            let message = NSAttributedString(string: "\nTake a photo of your favorite food plate and check the nutritional values. Tap on Save button to check it later.", attributes: lightAttribute)
            boldString.append(message)
            boldString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                    value: paragraphsStyle,
                                    range: NSMakeRange(0, boldString.length))
            return boldString
        }
    }
    
    func processImage(image: UIImage) {
        self.recogniseFood(image: image, completion: { () in
            print("Finished")
            self.delegate?.updateUI()
        })
    }
    
    private func recogniseFood(image: UIImage, completion: @escaping () -> Void ) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let model = try? Food101() else {
                print("Could Not Load Food Model")
                return
            }
            guard let input = model.preprocess(image: image) else {
                print("preprocessing failed")
                return
            }
            if let result = try? model.prediction(image: input) {
                // let confidence = result.foodConfidence["\(result.classLabel)"]! * 100.0
                // let converted = String(format: "%.2f", confidence)
                PhotoRecognitionStateModel.sharedInstance.recognizedFoodName = result.classLabel
                PhotoRecognitionStateModel.sharedInstance.foodImage = image.resize(to: Food101.imageSize)
                DispatchQueue.main.async {
                    completion()
                    print("\(result.foodConfidence)")
                }
            } else {
                print("prediction failed")
                return
            }
        }
    }

}
