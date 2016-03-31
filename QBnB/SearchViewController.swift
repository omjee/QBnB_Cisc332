//
//  SearchViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var city: UITextField!
    @IBOutlet var prov: UITextField!
    @IBOutlet var type: UISegmentedControl!
    @IBOutlet var mibed: UITextField!
    @IBOutlet var mabed: UITextField!
    @IBOutlet var mibath: UITextField!
    @IBOutlet var mabath: UITextField!
    @IBOutlet var minprc: UITextField!
    @IBOutlet var maprc: UITextField!
    @IBOutlet var mirate: UITextField!
    @IBOutlet var marate: UITextField!
    
    @IBOutlet var syear: UITextField!
    @IBOutlet var smo: UITextField!
    @IBOutlet var sdat: UITextField!
    
    @IBOutlet var fyear: UITextField!
    @IBOutlet var fmo: UITextField!
    @IBOutlet var fdate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func TapGesture(sender: AnyObject) {
        
        self.view.endEditing(true);
    
    }
    
    // MARK: - Navigation

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "DoSearchSegue"
        {
            
            if syear.text! == "" || smo.text == "" || sdat.text == "" || fyear.text! == "" || fmo.text == "" || fdate.text == ""
            {
                let uiav = UIAlertController(title: "Error", message: "You must select booking dates.", preferredStyle: .Alert);
                uiav.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil));
                
                dispatch_async(dispatch_get_main_queue()){
                    self.presentViewController(uiav, animated: true, completion: nil);
                }
                
                return false;
                
            }
            else
            {
                return true;
            }
        }
        
        return true;
        
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "DoSearchSegue"
        {
            let vc = segue.destinationViewController as! UserPropertiesTableViewController;
            
            vc.thePostString = "district_field=&city_field=" + city.text! + "&province_field=" + prov.text! + "&type_field=";
            vc.thePostString += "&min_bedrooms=" + mibed.text! + "&max_bedrooms=" + mabed.text! + "&min_bathrooms=" + mibath.text! + "&max_bathrooms="
            vc.thePostString += mabath.text! + "&min_price=" + minprc.text! + "&maxprice=" + maprc.text! + "&min_rating=" + mirate.text!;
            vc.thePostString += "&max_rating=" + marate.text! + "&sdate_field=" + syear.text! + "-" + smo.text! + "-" + sdat.text!;
            vc.thePostString += "&edate_field=" + fyear.text! + "-" + fmo.text! + "-" + fdate.text!;

            vc.dateString = "sdate_field=" + syear.text! + "-" + smo.text! + "-" + sdat.text! + "&edate_field=" + fyear.text! + "-" + fmo.text! + "-" + fdate.text!;
            
            
        }
        
        
    }
    

}
