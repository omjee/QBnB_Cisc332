//
//  AdminViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet var FirstNameTextField: UITextField!
    @IBOutlet var MidInitialTextField: UITextField!
    @IBOutlet var LastNameTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var PhoneTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "FindMemberSegue"
        {
            let vc = segue.destinationViewController as! MemberAdminTableViewController;
            
            vc.thePostString = "first_name_field=" + FirstNameTextField.text! + "&middle_initial_field=" + MidInitialTextField.text!
            vc.thePostString += "&last_name_field=" + LastNameTextField.text! + "&email_field=" + EmailTextField.text! + "&primary_phone=" + PhoneTextField.text!;
            
        }
        
        
    }
    

}
