//
//  Constants.swift
//  DealDey
//
//  Created by JOHN on 6/21/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Url {
        static let BaseUrl  = "http://api-staging.dealdey.com/api/v1/"
        static let Deals = Url.BaseUrl+"deals/"
    }
    
    struct Colors {
        static let DealdeyGreen = UIColor(red: 159.0/255.0, green: 187.0/255.0, blue: 37.0/255.0, alpha: 1.0)
    }
    
    struct Time  {
    
        static let HoursInADay = 24
        static let SecondsInADay = 60
        static let SecondsInAHour = 3600
    }
    
}

