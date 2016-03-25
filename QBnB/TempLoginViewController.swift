//
//  TempLoginViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-19.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class TempLoginViewController: UIViewController {

    
    //@IBOutlet var LoginBanner: UILabel!
    @IBOutlet var LoginBanner: UITextView!
    
    var loginSession : NSURLSession!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/accountload.php")!);
        
        let accDataReq = loginSession.dataTaskWithRequest(request){(data,response,error) in
            dispatch_async(dispatch_get_main_queue()){
                self.LoginBanner.text = String(data: data!, encoding: NSUTF8StringEncoding);
            }
        }
        
        accDataReq.resume();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogoutButton_Click(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/logout.php")!);
        
        let logoutReq = loginSession.dataTaskWithRequest(request){(data,response,error) in
            dispatch_async(dispatch_get_main_queue()){
                self.dismissViewControllerAnimated(true, completion: nil);
                let uiav = UIAlertController(title: "Logout", message: String(data: data!, encoding: NSUTF8StringEncoding),preferredStyle: .Alert);
                uiav.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil));
                self.presentViewController(uiav,animated: true,completion: nil);
            }
        };
        
        logoutReq.resume();
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    /*

    Swag
    
   

    */

}
