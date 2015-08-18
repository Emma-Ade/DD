//
//  Deals.swift
//  DealDey
//
//  Created by JOHN on 6/22/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import Foundation

class Deals {
    
    let id: Int
    let shortTitle: String
    let discountedPrice: String
    let listingPrice: String
    var hoverLocation: String?
    var image: String?
    var highlights: String?
    var finePrints: String?
    var description: String?
    var percentageDiscount: String?
    var boughtCount: Int?
    var saving: Int?
    var showTimer: Bool?
    var timeLeft: Int?
    
    init(id: Int, shortTitle: String, discountedPrice: String, listingPrice: String){
        
        self.id = id
        self.shortTitle = shortTitle
        self.discountedPrice    = discountedPrice
        self.listingPrice   = listingPrice
    }
    
    
    class func DealsFromJSON(allResults: NSArray) -> [Deals] {
        
        // Create an empty array of Deals to append to from this list
        var deals = [Deals]()
        
        if allResults.count>0 {
            
            for result in allResults  {
                
                let id                  = result["id"] as? Int
                let shortTitle         = result["short_title"] as? String
                let hoverLocation      = result["hover_location"] as? String
                let image               = result["image"] as? String
                let least_priced_variant = result["least_priced_variant"]! as! NSDictionary
                let discountedPrice: AnyObject    = least_priced_variant["discounted_price"]!
                let listingPrice: AnyObject       = least_priced_variant["list_price"]!
           
                let newDeal = Deals(id: id! , shortTitle: shortTitle!, discountedPrice: toString(discountedPrice), listingPrice: toString(listingPrice) )
                newDeal.hoverLocation = hoverLocation
                newDeal.image = image
                
                deals.append(newDeal)
                
            }
        }
        return deals
    }
    
    
    class func DealDetailsFromJSON(result: NSDictionary) -> Deals {
        
        let Id = result["id"]! as! Int
        let shortTitle = result["short_title"]! as! String
        let hightlights = result["highlights"]! as! String
        let finePrints = result["fine_prints"]! as! String
        let description = result["description"]! as! String
        let percentageDiscount = result["percent_discount"]! as! String
        let boughtCount = result["bought_count"]! as! Int
        let listPrice: AnyObject = result["list_price"]!
        let saving = result["saving"]! as! Int
        let showTimer = result["show_timer"]! as! Bool
        let timeLeft = result["time_left"]! as! Int
        
        let deal = Deals(id: Id, shortTitle: shortTitle, discountedPrice: percentageDiscount, listingPrice: listPrice.stringValue )
        deal.highlights = hightlights
        deal.finePrints = finePrints
        deal.description = description
        deal.percentageDiscount = percentageDiscount
        deal.boughtCount = boughtCount
        deal.saving = saving
        deal.showTimer = showTimer
        deal.timeLeft = timeLeft
        
        return deal
    }
}