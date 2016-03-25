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
    
    var loginSession : NSURLSession!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInButton.backgroundColor = UIColor.whiteColor();
        LogInButton.layer.borderColor = UIColor.blackColor().CGColor;
        LogInButton.layer.borderWidth = 2.0;
        LogInButton.layer.cornerRadius = 4.0;
        
        self.UsernameField.delegate = self;
        self.PasswordField.delegate = self;
        
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration();
        sessionConfig.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always;
        sessionConfig.HTTPShouldSetCookies = true;
        loginSession = NSURLSession(configuration: sessionConfig);
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        let postString = "email=&password=";
        let loginURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/login.php")!);
        loginURLRequest.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        loginURLRequest.HTTPMethod = "POST";
        loginURLRequest.HTTPShouldHandleCookies = true;
        
        
        let loginTask = loginSession.dataTaskWithRequest(loginURLRequest){(data,response,error) in
            
            if let HTTPResponse = response as? NSHTTPURLResponse{
                
                if(HTTPResponse.statusCode == 200)
                {
                    dispatch_async(dispatch_get_main_queue()){
                        
                            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TempLoginVC") as! TempLoginViewController;
                            vc.loginSession = self.loginSession;
                            self.presentViewController(vc, animated: true, completion: nil)
                    
                    }
                }
            }
            
        }
        
        
        loginTask.resume();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackgroundTapped(sender: AnyObject) {
        self.view.endEditing(true);
    }
    
    @IBAction func LoginButton_TouchUpInside(sender: AnyObject) {
        let uiav = UIAlertController(title:"Please Wait",message: "Logging you in to QBnB...",preferredStyle: .Alert);
       
        
        
        self.presentViewController(uiav, animated: true, completion: { () -> Void in
          
        });
        
        
        let postString = "email=" + self.UsernameField.text! + "&password=" + self.PasswordField.text!
        
        
        
        let loginURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/login.php")!);
        
        loginURLRequest.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        loginURLRequest.HTTPMethod = "POST";
        loginURLRequest.HTTPShouldHandleCookies = true;
        
        
        
        let loginTask = loginSession.dataTaskWithRequest(loginURLRequest){(data,response,error) in
            if let HTTPResponse = response as? NSHTTPURLResponse, let fields = HTTPResponse.allHeaderFields as? [String : String]{
                
                let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(fields, forURL: response!.URL!)
                NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: response!.URL!, mainDocumentURL: nil)
                for cookie in cookies {
                    var cookieProperties = [String: AnyObject]()
                    cookieProperties[NSHTTPCookieName] = cookie.name
                    cookieProperties[NSHTTPCookieValue] = cookie.value
                    cookieProperties[NSHTTPCookieDomain] = cookie.domain
                    cookieProperties[NSHTTPCookiePath] = cookie.path
                    cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: cookie.version)
                    cookieProperties[NSHTTPCookieExpires] = NSDate().dateByAddingTimeInterval(31536000)
                    
                    let newCookie = NSHTTPCookie(properties: cookieProperties)
                    NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(newCookie!)
                    
                    print("name: \(cookie.name) value: \(cookie.value)")
                }
                
                
                
                
                
                
                if(HTTPResponse.statusCode != 200)
                {
                    dispatch_async(dispatch_get_main_queue()){
                    
                        uiav.title! = "Error " + String(HTTPResponse.statusCode);
                        uiav.message! = "There was an error logging you in. It's likely a bad username or password";
                    
                        let OKAction = UIAlertAction(title: "OK",style: .Cancel)
                        { (action) in
                        }
                    
                        uiav.addAction(OKAction);
                    }
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue()){
                        
                        uiav.dismissViewControllerAnimated(true, completion: { () -> Void in
                            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TempLoginVC") as! TempLoginViewController;
                            vc.loginSession = self.loginSession;
                            self.presentViewController(vc, animated: true, completion: nil)
                        })
                    }
                    
                    
                }
                

                
                //let uiav = UIAlertView(title: "Server Response: " + String(HTTPResponse.statusCode),message: cookies.description,delegate:self,cancelButtonTitle:"OK");
                //uiav.show();
            }
        }
        
        loginTask.resume();

        
    }
    
    @IBAction func ForgotPassword_TouchUpInside(sender: AnyObject)
    {
        
        let getEmailViewController = UIAlertController(title: "Forgot Password",message: "Enter your account's email address. Password reset instructions will be sent to your inbox.",preferredStyle: .Alert);
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default){ (action) in
           
        
            
            let postString = "email_field=" + getEmailViewController.textFields![0].text!
            
            let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/forgotpassword.php")!)
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPMethod = "POST"
            
            let task = self.loginSession.dataTaskWithRequest(request){ (data,response, error) in
                if let HTTPResponse = response as? NSHTTPURLResponse{
                    let statusCode = HTTPResponse.statusCode
                    
                    
                    dispatch_async(dispatch_get_main_queue())
                        {
                            let uiav = UIAlertController(title: "", message: "", preferredStyle: .Alert);
                            
                            if statusCode != 200
                            {
                                uiav.title = "Error " + String(statusCode);
                            }
                            else
                            {
                                uiav.title = "Success";
                            }
                    
                            uiav.message? = String(data: data!,encoding: NSUTF8StringEncoding)!
                    
                
                            
                            uiav.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil));
                            
                            self.presentViewController(uiav, animated: true, completion: nil);
                    }
                }

                
            }
            
            task.resume();
            
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){ (action) in
            
        }
        
        getEmailViewController.addTextFieldWithConfigurationHandler {(textField) in
            textField.placeholder = "email address"
            textField.keyboardType = UIKeyboardType.EmailAddress;
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

