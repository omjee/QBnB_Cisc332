//
//  MyAccountViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet var AccountImage: UIImageView!
    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var DetailsLabel: UILabel!
    @IBOutlet var MoreDetailsLabel: UILabel!
    
    @IBOutlet var EditAccButton: UIButton!
    @IBOutlet var ChangePassword: UIButton!
    @IBOutlet var MyReviewsButton: UIButton!
    @IBOutlet var AdminButton: UIButton!
    @IBOutlet var CloseAccountButton: UIButton!
    
    @IBOutlet var ButtonStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.AccountImage.image = AccountProperties.profilePic;
        self.NameLabel.text = AccountProperties.fname + " " + AccountProperties.mi + " " + AccountProperties.lname;
        MoreDetailsLabel.text = "ID No. " + AccountProperties.acc_id;
        // Do any additional setup after loading the view.
        
        if AccountProperties.IsAdmin == false
        {
            self.ButtonStack.removeArrangedSubview(AdminButton);
        }
        
        
        EditAccButton.backgroundColor = UIColor.whiteColor();
        EditAccButton.alpha = 0.8;
        EditAccButton.layer.cornerRadius = 6.0;
        
        ChangePassword.backgroundColor = UIColor.whiteColor();
        ChangePassword.layer.cornerRadius = 6.0;
        ChangePassword.alpha = 0.8;
        
        MyReviewsButton.backgroundColor = UIColor.whiteColor();
        MyReviewsButton.layer.cornerRadius = 6.0;
        MyReviewsButton.alpha = 0.8;
        
        AdminButton.backgroundColor = UIColor.whiteColor();
        AdminButton.layer.cornerRadius = 6.0;
        AdminButton.alpha = 0.8;
        
        CloseAccountButton.backgroundColor = UIColor.whiteColor();
        CloseAccountButton.layer.cornerRadius = 6.0;
        CloseAccountButton.alpha = 0.8;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LogOutButton(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/logout.php")!);
        
        let logoutReq = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            dispatch_async(dispatch_get_main_queue()){
                self.dismissViewControllerAnimated(true, completion: nil);
            }
        };
        
        logoutReq.resume();
    
    }
  
    @IBAction func CloseAccount_Click(sender: AnyObject) {
    
        let uiac = UIAlertController(title: "Close Account", message: "This action will close your QBnB account. Are you sure you wish to do that?", preferredStyle: .Alert);
        
        let deleteAction = UIAlertAction(title: "Close Account", style: .Destructive)
        { (action) in
            
            let conf = UIAlertController(title: "Are you sure?", message: "Please enter your password to continue.", preferredStyle: .Alert);
            
            conf.addTextFieldWithConfigurationHandler{(textField) in
                textField.secureTextEntry = true;
            }
            
            let deleteAcc = UIAlertAction(title: "Close Account", style: .Destructive)
            {(action) in
                
                
                let postString = "passValidate=" + conf.textFields![0].text!;
                
                let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/closeaccount.php")!)
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                request.HTTPMethod = "POST"
                
                let task = URLSesh.loginSession.dataTaskWithRequest(request){ (data,response, error) in
                    if let HTTPResponse = response as? NSHTTPURLResponse{
                        let statusCode = HTTPResponse.statusCode
                        
                        
                            let uiav = UIAlertController(title: "", message: "", preferredStyle: .Alert);
                            
                            if statusCode != 200
                            {
                                uiav.title = "Error " + String(statusCode);
                                uiav.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil));
                            }
                            else
                            {
                                uiav.title = "Success";
                               
                                uiav.addAction(UIAlertAction(title: "OK", style: .Cancel)
                                {(action) in
                                    dispatch_async(dispatch_get_main_queue()){
                                        self.dismissViewControllerAnimated(true, completion: nil);
                                    }
                                })
                                
                                
                            }
                            
                            uiav.message? = String(data: data!,encoding: NSUTF8StringEncoding)!
                            
                            
                            dispatch_async(dispatch_get_main_queue())
                            {
                                self.presentViewController(uiav, animated: true, completion:nil);
                            }
                        
                            
                    
                        
                    }
                
                }//task
                
                task.resume();
                
                
                
            }//action
            
            
            let cancelAc = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
            
            conf.addAction(deleteAcc);
            conf.addAction(cancelAc);
            
            dispatch_async(dispatch_get_main_queue())
            {
                self.presentViewController(conf, animated: true, completion:nil);
            }
            
            
            
        }//action
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        
        uiac.addAction(deleteAction);
        uiac.addAction(cancelAction);
        
        dispatch_async(dispatch_get_main_queue())
        {
            self.presentViewController(uiac, animated: true, completion:nil);
        }
        
    
    }

    

}
