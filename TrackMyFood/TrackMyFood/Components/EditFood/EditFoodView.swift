//
//  EditFoodView.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/15/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
protocol EditFoodProtocol: class {
    func cancelEditingFood()
    func saveEditingFood(_ model: Food)
}

class EditFoodView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var proteinTextField: UITextField! {
        didSet { textFields.append(proteinTextField) }
    }
    @IBOutlet weak var carbTextField: UITextField! {
        didSet { textFields.append(carbTextField) }
    }
    @IBOutlet weak var fatTextField: UITextField! {
        didSet { textFields.append(fatTextField) }
    }
    @IBOutlet weak var caloriesTextField: UITextField! {
        didSet { textFields.append(caloriesTextField) }
    }
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: EditFoodProtocol?
    private var foodModel: Food = Food()
    private var textFields: [UITextField] = []
    
    static func getView(_ frame: CGRect, model: Food) -> EditFoodView? {
        var view: EditFoodView?
        view = Bundle.main.loadNibNamed("EditFoodView", owner: self, options: nil)?[0] as? EditFoodView
        view?.frame = frame
        view?.foodModel = model
        view?.initView()
        view?.setupView()
        view?.setupTextFields()
        return view
    }
    
    private func initView() {
        self.saveButton.layer.cornerRadius = 5
        self.cancelButton.layer.cornerRadius = 5
        self.saveButton.layer.masksToBounds = true
        self.cancelButton.layer.masksToBounds = true
    }
    
    private func setupTextFields() {
            for textField in textFields {
                textField.delegate = self
                textField.keyboardType = .numberPad
            }
    }
    
    private func setupView() {
        self.caloriesTextField.placeholder = String(foodModel.kCal ?? 0) + " kCal"
        self.caloriesTextField.text = String(foodModel.kCal ?? 0) + " kCal"
        
        self.fatTextField.placeholder = String(foodModel.fat ?? 0) + " grams"
        self.fatTextField.text = String(foodModel.fat ?? 0) + " grams"
        
        self.carbTextField.placeholder = String(foodModel.carbo ?? 0) + " grams"
        self.carbTextField.text = String(foodModel.carbo ?? 0) + " grams"
        
        self.proteinTextField.placeholder = String(foodModel.protein ?? 0) + " grams"
        self.proteinTextField.text = String(foodModel.protein ?? 0) + " grams"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if (reason == .committed) {
            let text = textField.text ?? "0"
            switch (textField) {
            case caloriesTextField:
                caloriesTextField.text = text + " kCal"
            default:
                textField.text = text + " grams"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    // MARK: - Action
    
    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.cancelEditingFood()
        self.removeFromSuperview()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.delegate?.saveEditingFood(foodModel)
    }
    
}
