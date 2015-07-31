//
//  Deals.swift
//  DealDey
//
//  Created by JOHN on 6/22/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import Foundation

class Deals {
    var id: Int
    var short_title: String
    var hover_location: String
    var image: String
    var discounted_price: String
    var listing_price: String
    
    init(id: Int, short_title: String, hover_location: String, image: String, discounted_price: String, listing_price: String){
        
        self.id                 = id
        self.short_title        = short_title
        self.hover_location     = hover_location
        self.image              = image
        self.discounted_price   = discounted_price
        self.listing_price      = listing_price
    }
    
    
    class func dealsWithJSON(allResults: NSArray) -> [Deals] {
        
        // Create an empty array of Deals to append to from this list
        var deals = [Deals]()
        
        if allResults.count>0 {
            
            for result in allResults  {
                
                let id                  = result["id"] as? Int
                let short_title         = result["short_title"] as? String
                let hover_location      = result["hover_location"] as? String
                let image               = result["image"] as? String
                
                var least_priced_variant = result["least_priced_variant"]! as! NSDictionary
                let discounted_price: AnyObject    = least_priced_variant["discounted_price"]!
                let listing_price: AnyObject       = least_priced_variant["list_price"]!
                
                
                let newDeal = Deals(id: id! , short_title: short_title!, hover_location: hover_location!, image: image!, discounted_price: toString(discounted_price), listing_price: toString(listing_price) )
                deals.append(newDeal)
                
                
            }
        }
        return deals
    }
    
    
}