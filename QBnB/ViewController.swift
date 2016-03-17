//
//  ViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-02-28.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var LogInButton: UIButton!
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var UsernameField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInButton.backgroundColor = UIColor.whiteColor();
        LogInButton.layer.borderColor = UIColor.blackColor().CGColor;
        LogInButton.layer.borderWidth = 2.0;
        LogInButton.layer.cornerRadius = 4.0;
        
        self.UsernameField.delegate = self;
        self.PasswordField.delegate = self;
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackgroundTapped(sender: AnyObject) {
        self.view.endEditing(true);
    }
    
    @IBAction func LoginButton_TouchUpInside(sender: AnyObject) {
        let uiav = UIAlertView.init(title: "Bonjour!", message: "Hello world. I finally got this damn UI to work! 😂", delegate: self, cancelButtonTitle: "Yoloswag...");
    
        uiav.show();
        
    }
    
    @IBAction func ForgotPassword_TouchUpInside(sender: AnyObject)
    {
        let getEmailAlert = UIAlertView(title: "Forgot Password",message: "Please enter your account email address. Password reset details will be sent to you.",delegate:self,cancelButtonTitle: "Submit");
        
        getEmailAlert.alertViewStyle = UIAlertViewStyle.PlainTextInput;
        
        getEmailAlert.show();
        
        let uiav = UIAlertView.init(title: "Yoloswag", message: getEmailAlert.textFieldAtIndex(0)!.text, delegate: self, cancelButtonTitle: "fuk u");
        
        uiav.show();
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true);
        return false;
    }
    
    
}

