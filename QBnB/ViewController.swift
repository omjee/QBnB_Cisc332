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
        //let uiav = UIAlertView.init(title: "Bonjour!", message: "Hello world. I finally got this damn UI to work! 😂", delegate: self, cancelButtonTitle: "Yoloswag...");
        let uiav = UIAlertController(title:"Error",message: "Login Failed. Bad username/password combination.",preferredStyle: .Alert);
       
        let OKAction = UIAlertAction(title: "OK",style: .Cancel)
            { (action) in
                
            }
        
        uiav.addAction(OKAction);
        
        self.presentViewController(uiav, animated: true, completion: { () -> Void in
            
        });
    }
    
    @IBAction func ForgotPassword_TouchUpInside(sender: AnyObject)
    {
        let getEmailViewController = UIAlertController(title: "Forgot Password",message: "Enter your account's email address. Password reset instructions will be sent to your inbox.",preferredStyle: .Alert);
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default){ (action) in
            let uiav = UIAlertView.init(title:"Swag",message: "",delegate:self,cancelButtonTitle:"Ok");
        
            
            let postString = "email_field=" + getEmailViewController.textFields![0].text!
            
            let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/forgotpassword.php")!)
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
                    
                    uiav.show()
                }
                
            }
            
            
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){ (action) in
            
        }
        
        getEmailViewController.addTextFieldWithConfigurationHandler {(textField) in
            textField.placeholder = "email address"
        }
        
        getEmailViewController.addAction(submitAction);
        getEmailViewController.addAction(cancelAction);
        
        self.presentViewController(getEmailViewController, animated: true){(Void) in
            //yolo
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true);
        return false;
    }
    
    
}

