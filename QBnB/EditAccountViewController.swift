//
//  EditAccountViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController {

    @IBOutlet var EditAccountWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.EditAccountWebView.loadRequest(NSURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/editaccount.php")!))
        
        // Do any additional setup after loading the view.
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

}
