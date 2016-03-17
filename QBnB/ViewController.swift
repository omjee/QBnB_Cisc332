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
        let uiav = UIAlertView.init(title: "Bonjour!", message: "Hello world. I finally got this damn UI to work! 😂", delegate: self, cancelButtonTitle: "Sure dude...");
    
        uiav.show();
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true);
        return false;
    }
    
    
}

