//
//  ApiController.swift
//  DealDey
//
//  Created by JOHN on 6/22/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import Foundation
import Haneke
import Alamofire

class APIController {
    
    let cache = Shared.JSONCache
    
    func getRequest(url:String, callback:(NSDictionary) -> ()){
    
        let URL = NSURL(string: url)!

        cache.fetch(URL: URL).onSuccess { JSON in
            
            callback(JSON.dictionary)
            
            }
            .onFailure { (error) -> () in
                println(error?.localizedDescription)
        }
    }

    
    func fetchRequest(url:String, callback:(NSDictionary) -> ()){
        
        let URL = NSURL(string: url)!
        
        Alamofire.request(.GET, url)
            .response { request, response, data, error in
                println(error)
        }
            .responseJSON { request, response, JSON, error in
                //println(JSON)
                callback(JSON as! NSDictionary)
        }
        
    }
    
    
    func getDeals(page: Int, callback: (NSDictionary) -> ()){
    
        getRequest("\(Constants.Url.BaseUrl)/\(Constants.Url.AllDeals)&per_page=10&page=\(page)", callback: callback)
    }
    
    func getDeal(dealId: Int, callback: (NSDictionary) -> ()){
        
        //println("\(Constants.Url.BaseUrl)/deals/\(dealId)?access_key=android-testing")
        fetchRequest("\(Constants.Url.BaseUrl)/deals/\(dealId)?access_key=android-testing", callback: callback)
    
    }
}