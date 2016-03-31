//
//  EditPropertyViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class EditPropertyViewController: UIViewController {

    var propertyID = "";
    
    var halt = true;
    
    @IBOutlet var EnabledSwitch: UISwitch!
    @IBOutlet var AccountDetails: UITextView!
    
    
    @IBAction func EnabledChanged(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/enabledisableproperty.php")!);
        
        
        
        request.HTTPBody = String("property_to_change_field=" + propertyID + "&enable_disable=" + String(Int(EnabledSwitch.on))).dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST";
        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            
        };
        
        task.resume();
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated);
        
        if propertyID == ""
        {
            self.title = "New Property"
        }
        else
        {
            //call grabData
            
            grabData();
            
            self.title = "Edit Property";
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func grabData()
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/propertyviewowner.php")!);
        request.HTTPBody = String("property_to_view=" + propertyID).dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST";
        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            
            if let htrsp = response as? NSHTTPURLResponse
            {
                print(htrsp.statusCode.description);
                
                do
                {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments);
                    
                    
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.AccountDetails.text! = jsonData.description;
                    }
                    
                    
                    
                    if let deets = jsonData["details"] as? [String : AnyObject]
                    {
                        if let en = deets["enabled"] as? Bool
                        {
                            
                            dispatch_async(dispatch_get_main_queue())
                            {
                                self.EnabledSwitch.on = en;
                            }
                        }
                    
                    }
                    
                    
                    /*
                    if let fh = jsonData["features"] as? [String : AnyObject]
                    {
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.AccountDetails.text! += fh.description;
                        }
                    }

                    if let ph = jsonData["photos"] as? [String : AnyObject]
                    {
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.AccountDetails.text! = ph.description;
                        }
                    }
                    
                    if let bk = jsonData["bookings"] as? [String : AnyObject]
                    {
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.AccountDetails.text! += bk.description;
                        }
                    }

                    if let rv = jsonData["reviews"] as? [String : AnyObject]
                    {
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.AccountDetails.text! += rv.description;
                        }
                    }*/
                    
                }
                catch
                {
                    print("sehfweghflwhernfpkrejhfluwerhfwl;strlgk");
                }
                
            }
            
        }
        
        task.resume();
        
        
    }

   
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if let vc = segue.destinationViewController as? MyPropertiesTableViewController
        {
            vc.loadData();
        }
        
    }
    

}
