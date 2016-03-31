//
//  Review.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import Foundation

class Review{
    
    // MARK: Properties
    
    var firstName,  lastName, streetName, city, province, postal_code, review_text : String;

    var middleInitial, reply_text : String;
    
    var propertyID, streetNumber,  rating : Int;
    
    var aptNumber : Int?;
    
    init (property_ID : Int, fname : String, mi : String, lname : String, sNumber : Int, sName : String, aptNumber : Int?, theCity : String, theProvince : String, postalCode : String, rating : Int, reviewText : String, replyText : String)
    {
        
        self.propertyID = property_ID;
        self.firstName = fname;
        self.middleInitial = mi;
        self.lastName = lname;
        self.streetName = sName;
        self.city = theCity;
        self.province = theProvince;
        self.postal_code = postalCode;
        self.review_text = reviewText;
        self.reply_text = replyText;
        
        self.streetNumber = sNumber;
        self.aptNumber = aptNumber;
        self.rating = rating;
        
        
    }
    
    
}