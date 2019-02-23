//
//  ParkPicker.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class ParkPicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var parks: [NationalPark]?
    
    // from data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let parks = parks {
            return parks.count
        }
        
        return 0
    }
    
    
    // from UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let parks = parks else { return nil }
        
        if parks.indices.contains(row) {
            return parks[row].fullName
        } else {
            return nil
        }
        
    }
    
    func parkFor(row: Int) -> NationalPark? {
     
        guard let parks = parks else { return nil }
        
        if parks.indices.contains(row) {
            return parks[row]
        } else {
            return nil
        }
    }
    
}
