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
    
    let api = APINetworking()
    weak var parentNavigationController : UIViewController?
    var deals = [Deals]()
    var page = 1
    var fetchedDeals: NSMutableArray = []
    var tableViewFooter : UIView?
    var footerActivityIndicator: UIActivityIndicatorView?
    var isLoading = false
    var refresh = false
    let limit = 10
    var dealDetailViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        fetchDeals(page)
        
        self.tableView.addPullToRefresh({ [weak self] in
            // some code
            sleep(1)
            
            self?.page = 1
            self?.refresh = true
            let cache = Shared.JSONCache
            self?.fetchedDeals = []
            //cache.remove(key: urlstr)
            cache.removeAll()
            self!.fetchDeals(self!.page)

        })
      
    }

    
    private func fetchDeals(page: Int){
        
        api.cacheFetch(Constants.Url.Deals+"?per_page=\(self.limit)&page=\(self.page)&access_key=android-testing"){
            (response) in
            self.loadDeals(response["deals"]! as! NSArray)
            self.isLoading = false
        }
    }
    
    
    private func loadDeals(dealsList: NSArray){
        
        self.fetchedDeals.addObjectsFromArray(dealsList as [AnyObject])
        self.deals = Deals.DealsFromJSON(self.fetchedDeals)
        
        if !refresh {
            
            var tempArray: NSMutableArray = []
            let count = self.tableView.numberOfRowsInSection(0)

            for var i = count; i < self.fetchedDeals.count; i++ {
                tempArray.addObject(NSIndexPath(forRow: i, inSection: 0))
            }
            
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(tempArray as [AnyObject],withRowAnimation: .Automatic)
            self.tableView.endUpdates()
            
        } else {
            
            self.tableView.reloadData()
            self.refresh = false
        }
      
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }

    
    override func viewDidAppear(animated: Bool) {
        
        self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true

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
        
        // Configure the cell...
       let deal = self.deals[indexPath.row]
       let cell : DealListTableViewCell = tableView.dequeueReusableCellWithIdentifier("DealListTableViewCell") as! DealListTableViewCell
        
        return DealListTableViewCell.loadCellForRow(cell, deal: deal)
        
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
            self.isLoading = true

        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
          parentNavigationController?.performSegueWithIdentifier("detail", sender: deals[indexPath.row])
        
        /*let selectedDeal = deals[indexPath.row]
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DealDetailViewController") as! DealDetailViewController
        detailViewController.deal = selectedDeal
        detailViewController.hidesBottomBarWhenPushed = true
        
        self.parentNavigationController?.pushViewController(detailViewController, animated: true)*/
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.tableView.fixedPullToRefreshViewForDidScroll()
        
    }

    func showFooterLoading(){
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 25, 0)
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        self.tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        tableView.tableFooterView = tableViewFooter

        self.footerActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.footerActivityIndicator!.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, 13)
        self.footerActivityIndicator!.startAnimating()
        tableViewFooter!.addSubview( footerActivityIndicator! )
        
        /** No stopping so you can see it **/
    }
    
}

