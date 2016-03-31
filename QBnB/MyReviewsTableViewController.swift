//
//  MyReviewsTableViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class MyReviewsTableViewController: UITableViewController {

    
    var reviews = [Review]();
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        grabReviews();
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return reviews.count;
    }

    
    func grabReviews()
    {
        reviews.removeAll();
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/myreviews.php")!)
        //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "GET"
        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){ (data,response,error) in
            
            if let HTTPResponse = response as? NSHTTPURLResponse
            {
                
                print(HTTPResponse.statusCode.description);
                
                do
                {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments);
                    //print(jsonData.description);
                    //print(jsonData.count);
                    
                    for i in 0...(jsonData.count - 1)
                    {
                        if let item = jsonData.objectAtIndex(i) as? [String: AnyObject]
                        {
                           
                            
                            
                                var middleInitial, reply_text : String;
                            
                                var aptNumber : Int?;
                           
                            
                                guard let firstName = item["first_name"] as? String else { print("failed first_name");break; }
                                guard let lastName = item["last_name"] as? String else { print("failed last_name");break; }
                                guard let streetName = item["street_name"] as? String else { print("failed street_name");break; }
                                guard let city = item["city"] as? String else { print("failed city_name");break; }
                                guard let province = item["province"] as? String else { print("failed province");break; }
                                guard let postal_code = item["postal_code"] as? String else { print("failed postalcode");break; }
                                guard let review_text = item["review_text"] as? String else { print("failed review_text");break; }
                                
                                guard let propertyID = item["property_ID"] as? Int else { print("failed propertyid");break; }
                                guard let streetNumber = item["street_number"] as? Int else { print("failed streetnumber");break; }
                                guard let rating = item["rating"] as? Int else { print("failed rating");break; }
                                
                                if let mi = item["middle_initial"] as? String
                                {
                                    middleInitial = mi;
                                }
                                else
                                {
                                    middleInitial = "";
                                }
                                
                                if let rt = item["reply_text"] as? String
                                {
                                    reply_text = rt;
                                }
                                else
                                {
                                    reply_text = "None";
                                }
                                
                                if let an = item["apt_number"] as? Int
                                {
                                    aptNumber = an;
                                }
                                else
                                {
                                    aptNumber = nil;
                                }
                                
                                
                            let review = Review(property_ID: propertyID, fname: firstName, mi: middleInitial, lname: lastName, sNumber: streetNumber, sName: streetName, aptNumber: aptNumber, theCity: city, theProvince: province, postalCode: postal_code, rating: rating, reviewText: review_text, replyText: reply_text);
                                
                            
                            self.reviews += [review];
                                
                            print(review.review_text);
                                
                           
                            
                           
                            
                            
                        }//end loopz
                        
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.tableView.reloadData();
                        }
                        
                    }
                    
                    
                }
                catch
                {
                    
                }
                

                
            }//end let response
            
            
        }//close task
        
        task.resume();

    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ReviewTableViewCell";
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReviewTableViewCell;

        let review = reviews[indexPath.row];
        
        var addrString = String(review.streetNumber) + " " + review.streetName + " ";
        
        if review.aptNumber != nil
        {
            addrString += "Apt. " + String(review.aptNumber!) + " ";
        }
        
        addrString += review.city + ", " + review.province + " " + review.postal_code;
        
        cell.AddressLabel.text = addrString;
        
        var ratingString = "";
        
        for _ in 1...review.rating
        {
            ratingString += "🌟";
        }
        
        cell.RatingLabel.text = ratingString;
        
        cell.ReviewLabel.text = review.review_text;
        
        cell.ResponseLabel.text = review.reply_text;
        
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
            
            
            
            //send request to server
            
            let review = reviews[indexPath.row];
            
            
            
            let postString = "property_to_view=" + String(review.propertyID);
            let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/deletereview.php")!)
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPMethod = "POST"
            
            let task = URLSesh.loginSession.dataTaskWithRequest(request);
            
            
            
            task.resume();
            
            self.reviews.removeAtIndex(indexPath.row);

            
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
