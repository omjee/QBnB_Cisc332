//
//  TabController.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if AccountProperties.IsSupplier == false
        {
            var vcs = self.viewControllers;
            
            vcs?.removeAtIndex(3);
            
            self.viewControllers = vcs;
            
        }

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
