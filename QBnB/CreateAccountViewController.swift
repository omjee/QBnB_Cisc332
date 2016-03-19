//
//  CreateAccountViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-17.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController,UITextFieldDelegate {

    //spinners for degree types
    @IBOutlet var YearPicker: UIPickerView!
    @IBOutlet var DegreePicker: UIPickerView!
    
    var degreeTypes = ["Bachelors","Masters","Ph.D.","M.D","J.D.","Du.D.E.","Other"];
    var facultyTypes = ["Arts","Commerce","Computing","Education","Engineering","Health Sci","Science","Law"];
    var initialYear = 1901;
    var years = ["1900"];
    
    //outlets for text fields
    
    
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    @IBOutlet var FirstNameTextField: UITextField!
    @IBOutlet var MiddleInitialTextField: UITextField!
    @IBOutlet var LastNameTextField: UITextField!
    @IBOutlet var PhoneNumberTextField: UITextField!
    @IBOutlet var ProfilePictureURLTextField: UITextField!
    
    @IBOutlet var CreateAccScrollView: UIScrollView!
    
    
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
    
    //delegate methods for text fields
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) ->Bool
    {
        guard let text = textField.text else { return true }
        
        
        if(textField == MiddleInitialTextField)
        {
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 1
        }
        else
        {
            return true;
        }
    }
    
    //delegate methods for picker/spinners
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
    
    @IBAction func SubmitAccount_Click(sender: AnyObject) {
        self.view.endEditing(true);
        
        var errorString = "";
        var postString = "";
        
        if(FirstNameTextField.text! == "")
        {
            errorString += "First name is blank\n";
        }
        else
        {
            postString += "first_name_field=" + FirstNameTextField.text! + "&";
        }
        
        if(MiddleInitialTextField.text! != "")
        {
            postString += "middle_initial_field=" + MiddleInitialTextField.text! + "&";
        }
        
        if(LastNameTextField.text! == "")
        {
            errorString += "Last name is blank\n";
        }
        else
        {
            postString += "last_name_field=" + LastNameTextField.text! + "&";
        }
        
        if(EmailTextField.text! == "")
        {
            errorString += "Email is blank\n"
        }
        else
        {
            postString += "email_field=" + EmailTextField.text! + "&"
        }
        
        if(PasswordTextField.text! == "")
        {
            errorString += "Password is blank\n";
        }
        else if (PasswordTextField.text! != ConfirmPasswordTextField.text!)
        {
            errorString += "Password does not match confirmation";
        }
        else
        {
            postString += "password_field=" + PasswordTextField.text! + "&";
        }
        
        if(PhoneNumberTextField.text! == "")
        {
            errorString +=  "Phone Number is blank\n";
        }
        else
        {
            postString += "primary_phone_field=" + PhoneNumberTextField.text! + "&"
        }
        
        if(ProfilePictureURLTextField.text! == "")
        {
            errorString += "Must choose a profile picture";
        }
        else
        {
            postString += "ppURL_field=" + ProfilePictureURLTextField.text! + "&";
        }
        
        postString += "year_field=" + years[YearPicker.selectedRowInComponent(0)] + "&";
        postString += "faculty_field=" + facultyTypes[DegreePicker.selectedRowInComponent(1)] + "&";
        postString += "type_field=" + degreeTypes[DegreePicker.selectedRowInComponent(0)];
        
        guard errorString == "" else
        {
            let uiav = UIAlertView.init(title: "Input Errors", message: "There are errors in your submission:\n\n" + errorString, delegate: self, cancelButtonTitle: "OK");
            uiav.show();
            return;
        }
        
        let uiav = UIAlertView.init(title:"Swag",message: "",delegate:self,cancelButtonTitle:"OK");
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/newaccount.php")!)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){ (response, data, error) in
            
            if let HTTPResponse = response as? NSHTTPURLResponse{
                let statusCode = HTTPResponse.statusCode
                
                if statusCode != 200
                {
                    uiav.title = "Error " + String(statusCode);
                }
                else
                {
                    uiav.title = "Success";
                }
                
                uiav.message? += String(data: data!,encoding: NSUTF8StringEncoding)!
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
                uiav.show()
            }
            
        }
        
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
