//
//  MemberAdmin.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import Foundation
import UIKit

class memberAdmin{
    
    var memberID, first_name, middle_initial, last_name, email, primary_phone, secondary_phone : String;
    var admin, supplier : Bool;
    var profilePicture : UIImage;
    
    
    init (memID : String, fname : String, mi : String, lname : String, eml : String, pphn : String, sphn : String, ppurl : UIImage, adm : Bool, sup : Bool)
    {
        memberID = memID;
        first_name = fname;
        middle_initial = mi;
        last_name = lname;
        email = eml;
        primary_phone = pphn;
        secondary_phone = sphn;
        profilePicture = ppurl;
        admin = adm;
        supplier = sup;
    }
    
    
}