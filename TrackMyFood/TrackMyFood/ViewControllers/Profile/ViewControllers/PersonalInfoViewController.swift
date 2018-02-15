//
//  PersonalInfoViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/9/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var femaleButton: BlueChambrayButton!
    @IBOutlet weak var maleButton: BlueChambrayButton!
    @IBOutlet weak var age: TwoStateLabel!
    @IBOutlet weak var height: TwoStateLabel!
    @IBOutlet weak var weight: TwoStateLabel!
    @IBOutlet weak var saveButton: UIButton!
    
    private var viewModel: PersonalInfoViewModel = PersonalInfoViewModel()
    
    private lazy var pickerView: UIPickerView = {
        let frameWidth = self.view.frame.size.width
        let frameHeight = self.view.frame.size.height
        let pickerHeight = frameHeight * 0.4
        
        let frame: CGRect = CGRect(x: 0, y: frameHeight - pickerHeight, width: frameWidth, height: pickerHeight)
        var picker = UIPickerView(frame: frame)
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGestureRecognizersToLabels()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        self.femaleButton.buttonState = .deselected
        self.maleButton.buttonState = .deselected
    }
    
    private func addGestureRecognizersToLabels() {
        let ageTap = UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.labelAgeTapped(_:)))
        let heightTap = UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.labelHeightTapped(_:)))
        let weightTap = UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.labelWeightTapped(_:)))
            
        age.isUserInteractionEnabled = true
        height.isUserInteractionEnabled = true
        weight.isUserInteractionEnabled = true
        
        age.addGestureRecognizer(ageTap)
        height.addGestureRecognizer(heightTap)
        weight.addGestureRecognizer(weightTap)
    }
    
    private func showPickerView() {
        // If there is a value already selected, scroll to that value.
        self.view.addSubview(pickerView)
        self.pickerView.alpha = 1.0
        self.pickerView.reloadAllComponents()
        if let presentedPicker = self.viewModel.pickerPresented {
            var row: Int = 0
            switch presentedPicker {
            case .age:
                if let labelText = age.text, let index = self.viewModel.pickerAgeOptions.index(of: labelText) {
                    row = index
                }
            case .height:
                if let labelText = height.text, let index = self.viewModel.pickerHeightOptions.index(of: labelText) {
                    row = index
                }
            case .weight:
                if let labelText = weight.text, let index = self.viewModel.pickerWeightOptions.index(of: labelText) {
                    row = index
                }
            }
            
            self.pickerView.selectRow(row, inComponent: 0, animated: true)
        }
    }

    @IBAction func genderAction(_ sender: BlueChambrayButton) {
        if (sender == maleButton) {
            self.maleButton.buttonState = .selected
            self.femaleButton.buttonState = .deselected
        }
        else {
            self.maleButton.buttonState = .deselected
            self.femaleButton.buttonState = .selected
        }
    }
    
    // MARK: - Picker View Delegate Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Since there are three labels, tapping on any of them invokes picker.
        if let pickerType = self.viewModel.pickerPresented {
            return self.viewModel.numberOfElementsInPicker(pickerType)
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Look at the comment for function for picker for numberOfRowsInComponent for mode details.
        return self.viewModel.pickerComponentForRow(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let picker = self.viewModel.pickerPresented {
            switch picker {
            case .age:
                self.age.text = self.viewModel.pickerAgeOptions[row] + " years"
            case .height:
                self.height.text = self.viewModel.pickerHeightOptions[row] + " cm"
            case .weight:
                self.weight.text = self.viewModel.pickerWeightOptions[row] + " kg"
            }
        }
        self.dismissPickerView()
    }
    
    // MARK: - Labels Tap Selectors
    
    @objc private func labelAgeTapped(_ sender: TwoStateLabel) {
        self.viewModel.pickerPresented = .age
        showPickerView()
        self.setLabelsState(selectedLabel: age)
    }
    
    @objc private func labelHeightTapped(_ sender: TwoStateLabel) {
        self.viewModel.pickerPresented = .height
        showPickerView()
        self.setLabelsState(selectedLabel: height)
    }
    
    @objc private func labelWeightTapped(_ sender: TwoStateLabel) {
        self.viewModel.pickerPresented = .weight
        showPickerView()
        self.setLabelsState(selectedLabel: weight)
    }
    
    private func dismissPickerView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            UIView.animate(withDuration: 0.5,
                           animations: { self.pickerView.alpha = 0.0 },
                           completion: { (value: Bool) in
                            self.setLabelsState(selectedLabel: nil)
                            self.pickerView.removeFromSuperview()
            })
        })
    }
    
    private func setLabelsState(selectedLabel: TwoStateLabel?) {
        switch selectedLabel {
        case height?:
            self.height.state = LabelState.selected
            self.weight.state = LabelState.deselected
            self.age.state = LabelState.deselected
        case weight?:
            self.height.state = LabelState.deselected
            self.weight.state = LabelState.selected
            self.age.state = LabelState.deselected
        case age?:
            self.height.state = LabelState.deselected
            self.weight.state = LabelState.deselected
            self.age.state = LabelState.selected
        default:
            self.height.state = LabelState.deselected
            self.age.state = LabelState.deselected
            self.weight.state = LabelState.deselected
        }
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        var profile: (age: Double, weight: Double, height: Double, isMale: Bool)
        profile.age = Double(self.age.text?.integerOnly ?? 0)
        profile.weight = Double(self.weight.text?.integerOnly ?? 0)
        profile.height = Double(self.height.text?.integerOnly ?? 0)
        profile.isMale = (self.maleButton.isSelected) ? true : false
        self.viewModel.saveChoicesToPlistFile(profile)
    }
    
}
