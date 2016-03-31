//
//  MyBookingsTableViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class MyBookingsTableViewController: UITableViewController {

    
    var bookings = [MyBookings]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       
        
    }

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
         grabData();
        
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
        return bookings.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyBookingsTableViewCell", forIndexPath: indexPath) as! MyBookingsTableViewCell

        let booking = bookings[indexPath.row];

        cell.BookString.text! = booking.bookingString;
        cell.Start.text! = booking.start_date;
        cell.End.text! = booking.end_date;
        cell.Status.text! = booking.bookingStatus;
        
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
            
            let booking = bookings[indexPath.row];
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/cancelbooking.php")!);
            request.HTTPBody = String("bookID_field=" + booking.booking_ID).dataUsingEncoding(NSUTF8StringEncoding);
            request.HTTPMethod = "POST";
            
            let task = URLSesh.loginSession.dataTaskWithRequest(request);
            
            task.resume();
        
            bookings.removeAtIndex(indexPath.row);
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func grabData()
    {
        bookings.removeAll();
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/bookingload.php")!);
        //request.HTTPBody = String("searchBtn=yolo&property_to_view=" + propertyID + "&" + dateString).dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "GET";
        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            
            if let htrsp = response as? NSHTTPURLResponse
            {
                do
                {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments);
                    
                    if jsonData.count > 0
                    {
                        
                        for i in 0...jsonData.count-1
                        {
                            
                            if let item = jsonData.objectAtIndex(i) as? [String : AnyObject]
                            {
                                
                              
                                
                               
                                
                                
                                //guard let firstName = item["first_name"] as? String else { print("failed first_name");break; }
                                //guard let lastName = item["last_name"] as? String else { print("failed last_name");break; }
                                guard let streetName = item["street_name"] as? String else { print("failed street_name");break; }
                                guard let city = item["city"] as? String else { print("failed city_name");break; }
                                guard let province = item["province"] as? String else { print("failed province");break; }
                                guard let propertyID = item["property_ID"] as? Int else { print("failed propertyid");break; }
                                guard let bookingID = item["booking_ID"] as? Int else { print("failed propertyid");break; }
                                guard let streetNumber = item["street_number"] as? Int else { print("failed streetnumber");break; }
                                
                                guard let startDate = item["start_date"] as? String else { print("failed st");break; }
                                guard let endDate = item["end_date"] as? String else { print("failed end");break; }
                                guard let leStatus = item["status"] as? String else { print("failed stat");break; }
                                
                                var bookString = String(streetNumber) + " " + streetName;
                                
                                if let an = item["apt_number"] as? Int
                                {
                                    bookString += " Apt. " + String(an) + ", ";
                                }
                                
                                bookString += " " + city + " " + province;
                                
                                let booking = MyBookings(id: String(bookingID), pid: String(propertyID), sdate: startDate, edate: endDate, bstring: bookString, status: leStatus);
                                
                                self.bookings += [booking];
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.tableView.reloadData();
                    }
                    
                    
                    
                }
                catch
                {
                    print("seofiuwhiefiwehfiiwhefiuwheif");
                }
                
                
                
                
            }//end response
            
        }//end task
        
        task.resume();
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
