//
//  RoomWorkFlowViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/24/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class RoomWorkFlowController: UIViewController {
    
    //Text fields
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    //Date picker references
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    
    //Tests not necessary
    var today = Date()
    var myDate: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RoomWorkFlowController.viewTappedToDeffer(gestureRecognier:)))
        
        view.addGestureRecognizer(tapGesture)
        
        //Start Date Picker
        startDatePicker = UIDatePicker()
        
        startDatePicker?.datePickerMode = .date
        
        startDatePicker?.addTarget(self, action: #selector(RoomWorkFlowController.startDateChanged(datePicker:)), for: .valueChanged)
        
        startDateTextField.inputView = startDatePicker
        
        //End Date Picker
        endDatePicker = UIDatePicker()
        
        endDatePicker?.datePickerMode = .date
        
        endDatePicker?.addTarget(self, action: #selector(RoomWorkFlowController.endDateChanged(datePicker:)), for: .valueChanged)
        
        endDateTextField.inputView = endDatePicker
    }
    
    @objc func startDateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        startDateTextField.textColor = UIColor.black
        
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func endDateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        endDateTextField.textColor = UIColor.black
        
        endDateTextField.text = dateFormatter.string(from: datePicker.date)
        
        today = datePicker.date
        
    }
    
    //Dismisses the DatePicker
    @objc func viewTappedToDeffer(gestureRecognier: UIGestureRecognizer){
        
        view.endEditing(true)
        
    }
    
}
