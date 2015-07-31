//
//  TestTableViewController.swift
//  DealDey
//
//  Created by JOHN on 6/21/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import UIKit
import MBProgressHUD
import Haneke

class DealListTableViewController: UITableViewController {
    
    var parentNavigationController : UINavigationController?
    var deals = [Deals]()
    var api = APIController()
    var page = 1
    var fullArr: NSMutableArray = []
    var tableViewFooter : UIView?
    var footerActivityIndicator: UIActivityIndicatorView?
    var isLoading = false
    var dealDetailViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        fetchDeals(page)
        self.tableView.registerNib(UINib(nibName: "DealListTableViewCell", bundle: nil), forCellReuseIdentifier: "DealListTableViewCell")
        
        self.tableView.addPullToRefresh({ [weak self] in
            // some code
            sleep(1)
            
            let cache = Shared.JSONCache
            self?.fullArr = []
            //cache.remove(key: urlstr)
            cache.removeAll()
            self!.fetchDeals(1)

        })
        
    }
    
    func fetchDeals(page: Int){
        
        api.getDeals(page){
            (response) in
            self.loadDeals(response["deals"]! as! NSArray)
            self.isLoading = false
        }

    }
    
    func loadDeals(dealsList: NSArray){
        
        self.fullArr.addObjectsFromArray(dealsList as [AnyObject])
        self.deals = Deals.dealsWithJSON(self.fullArr)
       
        tableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //println("\(self.title) page: viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
        
        //println("favorites page: viewDidAppear")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return deals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : DealListTableViewCell = tableView.dequeueReusableCellWithIdentifier("DealListTableViewCell") as! DealListTableViewCell
        
        // Configure the cell...
        let deal = self.deals[indexPath.row]
        
        cell.nameLabel.text = deal.short_title
        cell.discountedPrice.text = "₦\(deal.discounted_price) "
        cell.location.setTitle("\( deal.hover_location)", forState: UIControlState.Normal)
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "₦\(deal.listing_price)")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.listPrice.attributedText = attributeString

        
        let urlString = deal.image
        if let escapedUrlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
                var imgURL: NSURL = NSURL(string: escapedUrlString)!
                cell.photoImageView.hnk_setImageFromURL(imgURL)
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 230
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if (indexPath.row ==  deals.count - 1 && !isLoading) {
            //load more records here
            
            showFooterLoading()
            self.page += 1
            fetchDeals(page)
            isLoading = true

        }

    }

    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.tableView.fixedPullToRefreshViewForDidScroll()
        
    }


    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var dealIndex = tableView.indexPathForSelectedRow()!.row
        var selectedDeal = self.deals[dealIndex]
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dealDetailViewController = storyboard.instantiateViewControllerWithIdentifier("DealDetailViewController") as! DealDetailViewController
        //self.dealDetailViewController = UINavigationController(rootViewController: dealDetailViewController)
        
        dealDetailViewController.deal = selectedDeal
        dealDetailViewController.hidesBottomBarWhenPushed = true
        parentNavigationController!.pushViewController(dealDetailViewController, animated: true)
        
    }
    
    
    
    func showFooterLoading(){
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 25, 0)
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        self.tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        tableView.tableFooterView = tableViewFooter

        self.footerActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.footerActivityIndicator!.frame = CGRectMake(0, 0, 100, 100)
        self.footerActivityIndicator!.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, 0)
        self.footerActivityIndicator!.startAnimating()
        tableViewFooter!.addSubview( footerActivityIndicator! )
        
        /** No stopping so you can see it **/
    }
    
}

