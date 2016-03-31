//
//  AdminViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {

    
    //member crap
    @IBOutlet var FirstNameTextField: UITextField!
    @IBOutlet var MidInitialTextField: UITextField!
    @IBOutlet var LastNameTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var PhoneTextField: UITextField!
    
    //property crap
    @IBOutlet var CityField: UITextField!
    
    @IBOutlet var ProvinceField: UITextField!
    
    @IBOutlet var TypeSelector: UISegmentedControl!
    @IBOutlet var Minbed: UITextField!
    @IBOutlet var Maxbed: UITextField!
    @IBOutlet var minbath: UITextField!
    
    @IBOutlet var maxbath: UITextField!
    @IBOutlet var minprice: UITextField!
    @IBOutlet var maxprice: UITextField!
    @IBOutlet var minrate: UITextField!
    @IBOutlet var maxrate: UITextField!
    
    @IBOutlet var sv: UIScrollView!
    
    
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
        else if segue.identifier == "FindPropertiesSegue"
        {
            let vc = segue.destinationViewController as! AdminPropertiesTableViewController
            
            vc.thePostString = "district_field=&city_field=" + CityField.text! + "&province_field=" + ProvinceField.text! + "&type_field=";
            vc.thePostString += "&min_bedrooms=" + Minbed.text! + "&max_bedrooms=" + Maxbed.text! + "&min_bathrooms=" + minbath.text! + "&max_bathrooms="
            vc.thePostString += maxbath.text! + "&min_price=" + minprice.text! + "&maxprice=" + maxprice.text! + "&min_rating=" + minrate.text!;
            vc.thePostString += "&max_rating=" + maxrate.text!;
            
            
        }
        
        
    }
    

}
