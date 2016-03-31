//
//  AdminProperties.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import Foundation
import UIKit

class AdminProperties{
    
    var propertyID, fname, mi, lname, streetnum, streetname, aptnum, city, province, postalcode : String;
    var bedrooms, bathrooms : Int;
    var price : Int;
    var rating : Float;
    
    init(pid : String, fname1 : String, mi1 : String, lname1 : String, strnum : String, strname : String, aptnum1 : String, city1 : String, province1 : String, post : String, bed : Int,bath : Int, price1 : Int, rating1 : Float)
    {
        propertyID = pid;
        fname = fname1;
        mi = mi1;
        lname = lname1;
        streetnum = strnum;
        streetname = strname;
        aptnum = aptnum1;
        city = city1;
        province = province1;
        postalcode = post;
        bedrooms = bed;
        bathrooms = bath;
        price = price1;
        rating = rating1;
    }
    
    
}