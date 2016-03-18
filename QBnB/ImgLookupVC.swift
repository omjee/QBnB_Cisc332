//
//  ImgLookupVC.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-18.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class ImgLookupVC: UIViewController{

    @IBOutlet var ImgLookupWeb: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        ImgLookupWeb.loadRequest(NSURLRequest(URL: NSURL(string:"https://www.google.ca/search?tbm=isch&q=icon+variant")!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
            }

    @IBAction func BackButton(sender: AnyObject) {
        ImgLookupWeb.goBack()
    }
    
    @IBAction func CopyURl(sender: AnyObject) {
        
        UIPasteboard.generalPasteboard().string = ImgLookupWeb.request!.URL?.absoluteString;
        let uiav = UIAlertView.init(title:"Clipboard",message:"Copied\n\n" + (ImgLookupWeb.request!.URL?.absoluteString)! + " to the clipboard.",delegate:self,cancelButtonTitle:"OK")
        uiav.show()
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
