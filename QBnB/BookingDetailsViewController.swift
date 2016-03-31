//
//  BookingDetailsViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class BookingDetailsViewController: UIViewController {

    
    var propertyID = "";
    var dateString = "";
    
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var CaptionField: UITextView!
    @IBOutlet var StepperImg: UIStepper!
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var ReviewsTextBox: UITextView!
    
    
    
    var urls = [String]();
    var comments = [String]();
    var currentUrl = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        grabData();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MakeBookingClick(sender: AnyObject) {
    
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/addbooking.php")!);
        request.HTTPBody = String("searchBtn=yolo&property_to_view=" + propertyID + "&" + dateString).dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST";

        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
            
            if let htrsp = response as? NSHTTPURLResponse
            {
                
                print(String(data: data!, encoding: NSUTF8StringEncoding));
                
                if htrsp.statusCode != 200
                {
                    let uiav = UIAlertController(title: "Error " + htrsp.statusCode.description, message: "Could not make booking", preferredStyle: .Alert);
                    uiav.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil));
                    
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.presentViewController(uiav, animated: true, completion: nil);
                        }
                }
                else
                {
                    let uiav = UIAlertController(title: "Success " + htrsp.statusCode.description, message: "Successfully Made Booking.", preferredStyle: .Alert);
                    uiav.addAction(UIAlertAction(title: "OK", style: .Cancel)
                    {
                        (action) in
                        self.dismissViewControllerAnimated(true, completion: nil);

                        });
                    
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.presentViewController(uiav, animated: true,completion: nil);

                    }
                }
                
            }
            
        }
        
        task.resume();

    
    
    }
    
    @IBAction func StepperClick(sender: AnyObject) {
        currentUrl = Int(StepperImg.value);
        drawImage();
    }
    
    
    
    func grabData()
    {
        urls.removeAll();
        comments.removeAll();
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/propertyviewcustomer.php")!);
        request.HTTPBody = String("searchBtn=yolo&property_to_view=" + propertyID).dataUsingEncoding(NSUTF8StringEncoding);
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
                    
                    
                    if let photos = jsonData["photos"] as? [[String: AnyObject]]
                    {
                        for photo in photos
                        {
                            if let url = photo["photo_URL"] as? String
                            {
                                if let caption = photo["caption"] as? String
                                {
                                    self.urls += [url];
                                    self.comments += [caption];
                                }
                            }
                        }
                    }//end item parsing
                    
                    if let deets = jsonData["details"] as? [String: AnyObject]
                    {
                        var titleString = "";
                        
                        if let stnum = deets["street_number"] as? Int
                        {
                            titleString += String(stnum) + " ";
                        }
                        
                        if let stnam = deets["street_name"] as? String
                        {
                            titleString += String(stnam) + " ";
                        }
                        
                        if let apt = deets["apt_number"] as? Int
                        {
                            titleString += "Apt. " + String(apt) + " ";
                        }
                        
                        if let city = deets["city"] as? String
                        {
                            titleString += String(city) + ", ";
                        }
                        
                        if let prov = deets["province"] as? String
                        {
                            titleString += String(prov);
                        }
                        
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.TitleLabel.text! = titleString;
                        }
                        
                    }//end item parsing
                    
                    if let reviews = jsonData["reviews"] as? [[String: AnyObject]]
                    {
                        var reviewString = "";
                        
                        for review in reviews
                        {
                            
                            var tempString = "Review By: ";
                            
                            if let fname = review["first_name"] as? String
                            {
                                tempString += fname + " " ;
                            }
                            
                            if let lname = review["last_name"] as? String
                            {
                                tempString += lname + " " ;
                            }
                            
                            if let rating = review["rating"] as? Int
                            {
                                tempString += " - Rating " + String(rating) + "/5\n" ;
                            }
                            
                            if let rev = review["review_text"] as? String
                            {
                                tempString += "Review: " + rev + "\n";
                            }
                            
                            if let rep = review["reply_text"] as? String
                            {
                                if(rep != "")
                                {
                                    tempString += "Reply: " + rep + "\n";
                                }
                            }
                            
                            
                            reviewString += tempString + "\n";
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.ReviewsTextBox.text = reviewString;
                        }
                        
                    }
                    
                    
                    self.StepperImg.maximumValue = Double(self.urls.count);
                    self.StepperImg.stepValue = 1;
                    self.StepperImg.value = 0;
                    
                    self.drawImage();
                    
                    
                }
                catch
                {
                    
                }
                
            }
            
        }
        
        task.resume();
    }
    
    
    func drawImage()
    {
        dispatch_async(dispatch_get_main_queue())
        {
            self.StepperImg.userInteractionEnabled = false;
        }

        
        if(urls.count != 0 && currentUrl >= 0 && currentUrl < urls.count)
        {
            do
            {
                let imgData = try NSData(contentsOfURL: NSURL(string: urls[currentUrl])!, options: NSDataReadingOptions());
                
                
                dispatch_async(dispatch_get_main_queue())
                {
                    self.ImageView.image = UIImage(data: imgData);
                    self.CaptionField.text! = self.comments[self.currentUrl] ;
                    self.StepperImg.userInteractionEnabled = true;
                }
                
                
            }
            catch
            {
                
            }
            
        }
        else
        {
           
        }
        
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
