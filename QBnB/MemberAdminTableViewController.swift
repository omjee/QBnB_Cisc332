//
//  MemberAdminTableViewController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class MemberAdminTableViewController: UITableViewController {

    var thePostString = "";
    
    var members = [memberAdmin]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        //set post string
        getUsers();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberAdminCell", forIndexPath: indexPath) as! MemberTableViewCell

        let mem = members[indexPath.row];
        
        var adsu = "";
        
        if mem.admin
        {
            adsu += "A "
        }
        
        if mem.supplier
        {
            adsu += "S "
        }
        
        cell.AdSuLabel.text = adsu;
        
        cell.NameLabel.text = mem.first_name + " " + mem.middle_initial + " " + mem.last_name;
        cell.PhoneLabel.text = mem.primary_phone;
        cell.EmailLabel.text = mem.email;
        
        cell.MemberPicture.image = mem.profilePicture;
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        let member = members[indexPath.row];
        
        if(String(member.memberID) == AccountProperties.acc_id)
        {
            return false
        }
        
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            
            let member = members[indexPath.row];
            
            
            if(String(member.memberID) != AccountProperties.acc_id)
            {
                let postString = "member_ID_field=" + String(member.memberID);
                let request = NSMutableURLRequest(URL: NSURL(string:"http://Mitchells-iMac.local/admindeletemember.php")!)
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                request.HTTPMethod = "POST"
                
                let task = URLSesh.loginSession.dataTaskWithRequest(request);
                
                
                
                task.resume();
                
                members.removeAtIndex(indexPath.row);
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "MemberSummarySegue"
        {
            let dest = segue.destinationViewController as! MemberSummaryViewController;
            if let cell = sender as? MemberTableViewCell
            {
                let index = tableView.indexPathForCell(cell)!.row;
                dest.memberIDString = members[index].memberID;
            }
            
        }
        
        
    }
    

    func getUsers()
    {
        members.removeAll();
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://Mitchells-iMac.local/adminfindmember.php")!);
        request.HTTPBody = String("searchBtn=yolo&" + thePostString).dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST";
        
        let task = URLSesh.loginSession.dataTaskWithRequest(request){(data,response,error) in
         
            if let htrsp = response as? NSHTTPURLResponse
            {
                print(htrsp.statusCode.description);
                
                
                do
                {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments);
                    
                    for i in 0...(jsonData.count - 1)
                    {
                        if let item = jsonData.objectAtIndex(i) as? [String: AnyObject]
                        {
                            print(item.description);
                            
                            var middleInitial, secondaryPhone : String;
                            var img : UIImage;
                            
                            
                            guard let firstName = item["first_name"] as? String else { print("failed first_name");break; }
                            guard let lastName = item["last_name"] as? String else { print("failed last_name");break; }
                            guard let email = item["email"] as? String else { print("failed email");break; }
                            guard let memberid = item["member_ID"] as? Int else { print("failed id");break; }
                            
                            guard let primphone = item["primary_phone"] as? String else { print("failed pphn");break; }
                            
                            guard let adm = item["admin"] as? Bool else { print("failed adm");break; }
                            guard let sup = item["supplier"] as? Bool else { print("failed sup");break; }
                            
                            if let mi = item["middle_initial"] as? String
                            {
                                middleInitial = mi;
                            }
                            else
                            {
                                middleInitial = "";
                            }
                            
                            if let sc = item["secondary_phone"] as? String
                            {
                                secondaryPhone = sc;
                            }
                            else
                            {
                                secondaryPhone = "";
                            }
                            
                            if let url = item["profile_pic_URL"] as? String
                            {
                                do
                                {
                                    let imgData = try NSData(contentsOfURL: NSURL(string: url)!, options: NSDataReadingOptions());
                                    img = UIImage(data: imgData)!;
                                }
                                catch
                                {
                                    img = UIImage(named:"ic_account_box_black_48dp")!;
                                    print(ErrorType);
                                }
                            }
                            else
                            {
                                img = UIImage(named:"ic_account_box_black_48dp")!;
                            }
                            
                            
                            let mem = memberAdmin(memID: String(memberid), fname: firstName, mi: middleInitial, lname: lastName, eml: email, pphn: primphone, sphn: secondaryPhone, ppurl: img, adm: adm, sup: sup);
                            
                            self.members += [mem]

                            
                            
                            
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
        
    }//end teask
    
    
    
    
}
