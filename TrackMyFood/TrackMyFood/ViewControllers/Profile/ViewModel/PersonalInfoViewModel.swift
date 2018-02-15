//
//  PersonalInfoViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/17/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

class PersonalInfoViewModel {
    
    public enum PickerType {
        case height
        case weight
        case age
    }
        
    public var pickerHeightOptions: [String] {
        get {
            var options: [String] = []
            for index in 120...230 {
                options.append("\(index)")
            }
            return options
        }
    }
    
    public var pickerWeightOptions: [String] {
        get {
            var options: [String] = []
            for index in 15...200 {
                options.append("\(index)")
            }
            return options
        }
    }
    
    public var pickerAgeOptions: [String] {
        get {
            var options: [String] = []
            for index in 15...70 {
                options.append("\(index)")
            }
            return options
        }
    }
    
    public var pickerPresented: PickerType?
    public typealias Profile = (age: Double, weight: Double, height: Double, isMale: Bool)
    
    init() {
    }
    
    func numberOfElementsInPicker(_ pickerType: PickerType) -> Int {
        switch pickerType {
        case .age:
            return self.pickerAgeOptions.count
        case .height:
            return self.pickerHeightOptions.count
        case .weight:
            return self.pickerHeightOptions.count
        }
    }
    
    func pickerComponentForRow(_ row: Int) -> String {
        switch pickerPresented {
        case .age?:
            return self.pickerAgeOptions[row]
        case .height?:
            return self.pickerHeightOptions[row]
        case .weight?:
            return self.pickerWeightOptions[row]
        case .none:
            return ""
        }
    }
    
    func saveChoicesToPlistFile(_ profile: Profile) {
        if let plist = Plist(name: "Profile"), let dictionary = plist.getMutablePlistFile() {
            dictionary["MALE"] = profile.isMale
            dictionary["AGE"] = profile.age
            dictionary["HEIGHT"] = profile.height
            dictionary["WEIGHT"] = profile.weight
            dictionary.write(toFile: plist.destPath!, atomically: false)
        }
        else {
            print("ERROR: Could not save Profile data to *.plist file")
        }
    }
    
}
