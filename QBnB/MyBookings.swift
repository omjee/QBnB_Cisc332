//
//  MyBookings.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import Foundation

class MyBookings
{
    var booking_ID, property_ID, start_date, end_date, bookingString, bookingStatus : String;
    
    init(id : String, pid : String ,sdate : String, edate : String, bstring : String, status : String)
    {
        booking_ID = id;
        property_ID = pid;
        start_date = sdate;
        end_date = edate;
        bookingString = bstring;
        bookingStatus = status;
    }
    
}