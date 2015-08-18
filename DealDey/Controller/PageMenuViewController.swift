//
//  ViewController.swift
//  DealDey
//
//  Created by JOHN on 6/21/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import UIKit
import PageMenu

class PageMenuViewController: UIViewController, CAPSPageMenuDelegate {

    var pageMenu : CAPSPageMenu?
    var menu = ["All", "City", "Home", "Fashion", "Gadgets"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPageMenu()
    }
    
    
    // MARK: - Scroll menu setup
    
    private func setUpPageMenu(){
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        /*** Showing all deals on all tabs ***/
        
        for i in 0..<menu.count {
           
            var controller : DealListTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DealListTableViewController") as! DealListTableViewController
            controller.parentNavigationController = self
            controller.title = menu[i]
            controllerArray.append(controller)
        }
        
        // Customize menu (Optional)
        var parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor.colorWithValue(redValue: 247, greenValue: 247, blueValue: 247, alpha: 1.0)),
            .BottomMenuHairlineColor(UIColor.colorWithValue(redValue: 20, greenValue: 20, blueValue: 20, alpha: 0.1)),
            .SelectionIndicatorColor(Constants.Colors.DealdeyGreen),
            .MenuMargin(20.0),
            .MenuHeight(40.0),
            .SelectedMenuItemLabelColor(Constants.Colors.DealdeyGreen),
            .UnselectedMenuItemLabelColor(UIColor.colorWithValue(redValue: 40, greenValue: 40, blueValue: 40.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorRoundEdges(true),
            .SelectionIndicatorHeight(2.0),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // Optional delegate
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
    }
    

    func didMoveToPage(controller: UIViewController, index: Int) {
        println("did move to page")

    }
    
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        println("will move to page")
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detail"{
            let detailsViewController = segue.destinationViewController as! DealDetailViewController
            detailsViewController.deal  =   sender as? Deals
            detailsViewController.hidesBottomBarWhenPushed = true
        }
    }

}