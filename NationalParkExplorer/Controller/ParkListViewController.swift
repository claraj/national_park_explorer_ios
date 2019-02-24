//
//  ViewController.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class ParkListViewController: UIViewController {
    
    @IBOutlet var statePickerView: UIPickerView!
    @IBOutlet var parkPickerView: UIPickerView!
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var statePicker: StatePicker?
    var parkPicker: ParkPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "National Parks Explorer"
        
        statePicker = StatePicker(states: States.stateNames)
        statePickerView.dataSource = statePicker
        statePickerView.delegate = statePicker
        
        parkPicker = ParkPicker()
        parkPickerView.dataSource = parkPicker
        parkPickerView.delegate = parkPicker
    }
    
    
    @IBAction func showParksButtonTapped(_ sender: Any) {
        
        let row = statePickerView.selectedRow(inComponent: 0)
        let stateName = statePicker!.stateFor(row: row)
        let stateAbbr = States.stateAbbreviation(for: stateName)
        getParks(for: stateAbbr!)
    }
    
    
    func getParks(for state: String) {
        
        loadingIndicator.startAnimating()
        
        let service = NationalParksService()
        service.fetchParks(for: state) { (parks: [NationalPark]?, error: Error?) -> Void  in
            
            DispatchQueue.main.async {
            
                self.loadingIndicator.stopAnimating()
                
                if let error = error {
                    print(error)
                    self.present(ErrorAlertController.alert(message: "Unable to fetch parks") , animated: true)
                }
                
                if let parks = parks {
                    self.parkPicker!.parks = parks
                    self.parkPickerView.reloadAllComponents()
                    self.parkPickerView.selectRow(0, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "explorePark" {
            // what park selected?
            let selectedRow = parkPickerView.selectedRow(inComponent: 0)
            let park = parkPicker?.parkFor(row: selectedRow)
            
            let imageViewController = segue.destination as! ImageCollectionViewController
            imageViewController.park = park
        }
    }
}

