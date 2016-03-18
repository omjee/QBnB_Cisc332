//
//  CreateAccountViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-17.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    @IBOutlet var YearPicker: UIPickerView!
    @IBOutlet var DegreePicker: UIPickerView!
    
    var degreeTypes = ["Bachelors","Masters","Ph.D.","M.D","J.D.","Du.D.E.","Other"];
    var facultyTypes = ["Arts","Commerce","Computing","Education","Engineering","Health Sci","Science","Law"];
    var initialYear = 1901;
    var years = ["1900"];
    
    override func viewDidLoad() {
       
        let date = NSDate();
        let cal = NSCalendar.currentCalendar();
        let cmp = cal.components([.Year],fromDate: date);
        let year = cmp.year;
        
        for i in initialYear...(year + 4)
        {
            years.append(String(i));
        }
        
        super.viewDidLoad()
        
        YearPicker.selectRow(years.count - 1, inComponent: 0, animated: true);
        DegreePicker.selectRow(4, inComponent: 1, animated: true);
        DegreePicker.selectRow(5, inComponent: 0, animated: true);
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if(pickerView == YearPicker)
        {
            return 1;
        }
        else
        {
            return 2;
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      
        
        
        if(pickerView == YearPicker)
        {
            return years.count;
        }
        else
        {
            if component == 0{
                return degreeTypes.count;
            }
            else if component == 1{
                return facultyTypes.count;
            }
            else
            {
                return 0;
            }
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
        if(pickerView == YearPicker)
        {
            return years[row];
        }
        else
        {
        
            if component == 0{
                return degreeTypes[row];
            }
            else if component == 1{
                return facultyTypes[row];
            }
            else
            {
                return "yolo"
            }
        }
    }
    
    @IBAction func BackButton_Click(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func TapRecognized(sender: AnyObject) {
        self.view.endEditing(true);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
