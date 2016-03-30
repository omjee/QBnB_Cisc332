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
    
    @IBOutlet var MyAccountButton: UIButton!
    @IBOutlet var SearchButton: UIButton!
    @IBOutlet var MyBookingsButton: UIButton!
    @IBOutlet var MyPropertiesButton: UIButton!
    @IBOutlet var AdministrationButton: UIButton!
    
    @IBOutlet var ButtonStack: UIStackView!
    @IBOutlet var IDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        dispatch_async(dispatch_get_main_queue()){
            self.AccountImageView.image = AccountProperties.profilePic;
            self.NameLabel.text = AccountProperties.fname + " " + AccountProperties.lname
            
            self.IDLabel.text = "ID No: " + AccountProperties.acc_id;
            
            
            if AccountProperties.IsAdmin == false
            {
                self.ButtonStack.removeArrangedSubview(self.AdministrationButton);
            }
            
            if AccountProperties.IsSupplier == false
            {
                self.ButtonStack.removeArrangedSubview(self.MyPropertiesButton);
            }
            
            
            self.MyAccountButton.backgroundColor = UIColor.whiteColor();
            self.MyAccountButton.layer.cornerRadius = 6.0;
            self.MyAccountButton.alpha = 0.8;
            
            self.SearchButton.backgroundColor = UIColor.whiteColor();
            self.SearchButton.layer.cornerRadius = 6.0;
            self.SearchButton.alpha = 0.8;

            self.MyBookingsButton.backgroundColor = UIColor.whiteColor();
            self.MyBookingsButton.layer.cornerRadius = 6.0;
            self.MyBookingsButton.alpha = 0.8;

            self.MyPropertiesButton.backgroundColor = UIColor.whiteColor();
            self.MyPropertiesButton.layer.cornerRadius = 6.0;
            self.MyPropertiesButton.alpha = 0.8;

            self.AdministrationButton.backgroundColor = UIColor.whiteColor();
            self.AdministrationButton.layer.cornerRadius = 6.0;
            self.AdministrationButton.alpha = 0.8;

        }
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
