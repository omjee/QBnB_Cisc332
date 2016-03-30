//
//  HomeTabViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-29.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {

    @IBOutlet var AccountImageView: UIImageView!
    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var MyPropertiesButton: UIButton!
    @IBOutlet var AdministrationButton: UIButton!
    @IBOutlet var IDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        dispatch_async(dispatch_get_main_queue()){
            self.AccountImageView.image = AccountProperties.profilePic;
            self.NameLabel.text = AccountProperties.fname + " " + AccountProperties.lname
            
            self.IDLabel.text = "ID No: " + AccountProperties.acc_id;
            
            
            if AccountProperties.IsAdmin == true
            {
                self.AdministrationButton.userInteractionEnabled = true;
                self.AdministrationButton.tintColor = UIColor.whiteColor();
            }
            
            if AccountProperties.IsSupplier == true
            {
                self.MyPropertiesButton.userInteractionEnabled = true;
                self.MyPropertiesButton.tintColor = UIColor.whiteColor();
            }
            
        }
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LogOutButton_Click(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/logout.php")!);
        
        let logoutReq = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            dispatch_async(dispatch_get_main_queue()){
                self.dismissViewControllerAnimated(true, completion: nil);
                let uiav = UIAlertController(title: "Logout", message: String(data: data!, encoding: NSUTF8StringEncoding),preferredStyle: .Alert);
                uiav.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil));
                self.presentViewController(uiav,animated: true,completion: nil);
            }
        };
        
        logoutReq.resume();
    }
    
    @IBAction func MyAccount_Click(sender: AnyObject) {
        
        if AccountProperties.IsSupplier == true
        {
            self.tabBarController?.selectedIndex = 4;
        }
        else
        {
            self.tabBarController?.selectedIndex = 3;

        }
    }
    
    @IBAction func Search_Click(sender: AnyObject) {
    self.tabBarController?.selectedIndex = 1;
    }
    
    @IBAction func Bookings_Click(sender: AnyObject) {
    self.tabBarController?.selectedIndex = 2;
    }
    
    @IBAction func Properties_Click(sender: AnyObject) {
    self.tabBarController?.selectedIndex = 3;
    }
    
    @IBAction func Administration_Clock(sender: AnyObject) {
        if AccountProperties.IsSupplier == true
        {
            self.tabBarController?.selectedIndex = 4;
        }
        else
        {
            self.tabBarController?.selectedIndex = 3;
            
        }
    }
    
    func populateHomeTab()
    {
        
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
