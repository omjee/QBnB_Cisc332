//
//  AdminPropertiesTableViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class AdminPropertiesTableViewController: UITableViewController {

    var thePostString = "";
    
    var properties = [AdminProperties]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        getProperties();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return properties.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AdminTableCell", forIndexPath: indexPath) as! AdminPropertiesTableViewCell

        // Configure the cell...
        
        let prop = properties[indexPath.row];
        
        cell.PropertyNam.text! = prop.fname + " " + prop.lname;
        
        cell.PropertyAddr.text! = prop.streetnum + " " + prop.streetname;
        
        if prop.aptnum != ""
        {
            cell.PropertyAddr.text! += " Apt. " + prop.aptnum;
        }
        
        cell.PropertyAddr.text! += " " + prop.city + ", " + prop.province;
        
        cell.PropertyFeat.text! = String(prop.bedrooms) + " Bedrooms " + String(prop.bathrooms) + " Bathrooms"

        cell.PriceLabel.text! = "$" + String(prop.price);
        
        cell.RatingLabel.text! = "Rating: " + String(prop.rating);
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PropertiesSummarySegue"
        {
            let dest = segue.destinationViewController as! MemberSummaryViewController;
            if let cell = sender as? AdminPropertiesTableViewCell
            {
                let index = tableView.indexPathForCell(cell)!.row;
                dest.memberIDString = "http://Mitchells-iMac.local/adminsummarizeproperty.php?property_ID_field=" + properties[index].propertyID;
            }
            
        }
    }
    
    
    func getProperties()
    {
        
        properties.removeAll();
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/adminfindproperty.php")!);
        request.HTTPBody = String("searchBtn=yolo&" + thePostString).dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST";
        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            
            if let htrsp = response as? NSHTTPURLResponse
            {
                print(htrsp.statusCode.description);
                
                
                do
                {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments);
                    
                    if jsonData.count == 0
                    {
                        return;
                    }
                    
                    for i in 0...(jsonData.count - 1)
                    {
                        if let item = jsonData.objectAtIndex(i) as? [String: AnyObject]
                        {
                            print(item.description);
                            
                            var aptnum, middleInitial : String;
                            var rating : Float;
                            
                            guard let firstName = item["first_name"] as? String else { print("failed first_name");break; }//
                            guard let lastName = item["last_name"] as? String else { print("failed last_name");break; }//
                            guard let streetName = item["street_name"] as? String else { print("failed street_name");break; }
                            guard let city = item["city"] as? String else { print("failed city_name");break; }
                            guard let province = item["province"] as? String else { print("failed province");break; }
                            guard let postal_code = item["postal_code"] as? String else { print("failed postalcode");break; }
                            
                            guard let acc_text = item["accomodation_type"] as? String else { print("failed acc");break; }
                            
                            guard let bedrooms = item["num_bedrooms"] as? Int else { print("failed bed propertyid");break; }
                            guard let bathrooms = item["num_bathrooms"] as? Int else { print("failed bath propertyid");break; }
                            
                            guard let propertyID = item["property_ID"] as? Int else { print("failed propertyid");break; }
                            
                            guard let streetNumber = item["street_number"] as? Int else { print("failed streetnumber");break; }
                            
                            //guard let price = item["price"] as? Int else { print("failed price");break; }
                            
                            let price = 0;
                            
                            if let mi = item["middle_initial"] as? String
                            {
                                middleInitial = mi;
                            }
                            else
                            {
                                middleInitial = "";
                            }
                            
                            
                            if let anum = item["apt_number"] as? Int
                            {
                                aptnum = String(anum);
                            }
                            else
                            {
                                aptnum = "";
                            }
                            
                            if let ar = item["AVG(rating)"] as? Float
                            {
                                rating = ar;
                            }
                            else
                            {
                                rating = 0;
                            }
                        
                            
                            
                            let pro = AdminProperties(pid: String(propertyID), fname1: firstName, mi1: middleInitial, lname1: lastName, strnum: String(streetNumber), strname: streetName, aptnum1: String(aptnum), city1: city, province1: province, post: postal_code, bed: bedrooms, bath: bathrooms, price1: price, rating1: rating);
                            
                            self.properties += [pro];
                            
                            
                            
                            
                        }//end item parsing
                    }//end for
                    
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.tableView.reloadData();
                    }
                    
                }
                catch
                {
                    
                }
                
            }
            
        }
        
        task.resume();

    }
    
    
    

}
