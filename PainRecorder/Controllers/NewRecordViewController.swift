//
//  NewRecordViewController.swift
//  PainRecorder
//
//  Created by elina.zambere on 23/02/2021.
//

import UIKit
import CoreData

class NewRecordViewController: UIViewController {
    
    var records: JournalMO!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var painTextField: UITextField!
    @IBOutlet weak var painScaleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    let painVariant = ["Back pain", "Headache"]
    let painScale = ["1 - Pain Barable", "2 - Moderate Pain", "3 - Serve Pain", "4 - Very Serve Pain", "5 - Worst Pain Possible"]
    
    var painVariantPickerView = UIPickerView()
    var painScalePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        dateTextField.inputView = datePicker
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.frame.size = CGSize(width: 0, height: 250)
        datePicker?.addTarget(self, action: #selector(datePickerValueChange(sender:)), for: UIControl.Event.valueChanged)
        //datePicker?.inputView = datePicker
        
        
        //time picker
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        timeTextField.text = formatter.string(from: time)
        timeTextField.textColor = .black
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChange(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        timeTextField.inputView = timePicker
        timePicker.preferredDatePickerStyle = .wheels
        
        painTextField.inputView = painVariantPickerView
        painScaleTextField.inputView = painScalePickerView
        
        
        painVariantPickerView.delegate = self
        painVariantPickerView.dataSource = self
        
        painScalePickerView.delegate = self
        painScalePickerView.dataSource = self
        
        painScalePickerView.tag = 2
        painVariantPickerView.tag = 1
        
        
        // Do any additional setup after loading the view.
    }
    

    
    @objc func timePickerValueChange (sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        timeTextField.text = formatter.string(from: sender.date)
        
    }
    
    @objc func datePickerValueChange (sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: sender.date)
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        dateTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
        painTextField.resignFirstResponder()
        painScaleTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
    
    

}

extension NewRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return painVariant.count
        case 2:
            return painScale.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return painVariant[row]
        case 2:
            return painScale[row]
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 1:
            painTextField.text = painVariant[row]
            painTextField.resignFirstResponder()
        case 2:
            painScaleTextField.text = painScale[row]
            painScaleTextField.resignFirstResponder()
        default:
            return
        }
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if dateTextField.text == "" || timeTextField.text == "" || painTextField.text == "" || painScaleTextField .text == "" || notesTextField.text == "" {
            let alertController = UIAlertController(title: "Error!", message: "New Pain Record cannot be saved. Please fill in all fields.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
            return
        
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            
            records = JournalMO(context: appDelegate.persistentContainer.viewContext)
            records.date = dateTextField.text
            records.time = timeTextField.text
            records.painType = painTextField.text
            records.painPower = painScaleTextField.text
            records.notes = notesTextField.text
            
            print("Saving data")
            appDelegate.saveContext()
            
        }
            
        
        dismiss(animated: true, completion: nil)
        
    }
    
}


}
