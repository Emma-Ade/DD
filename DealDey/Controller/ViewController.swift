//
//  ViewController.swift
//  DealDey
//
//  Created by JOHN on 6/21/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import UIKit
import MBProgressHUD
import PageMenu

class ViewController: UIViewController, CAPSPageMenuDelegate {

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPageMenu()
    }
    
    
    // MARK: - Scroll menu setup
    
    private func setUpPageMenu(){
        
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        /*** Showing all deals on all tabs ***/
        
        var controller1 : DealListTableViewController = DealListTableViewController(nibName: "DealListTableViewController", bundle: nil)
        controller1.parentNavigationController = self.navigationController
        controller1.title = "All"
        controllerArray.append(controller1)
        
        
        var controller2 : DealListTableViewController = DealListTableViewController(nibName: "DealListTableViewController", bundle: nil)
        controller2.title = "City"
        controller2.parentNavigationController = self.navigationController
        controllerArray.append(controller2)
        
        var controller3 : DealListTableViewController = DealListTableViewController(nibName: "DealListTableViewController", bundle: nil)
        controller3.title = "Home"
        controller3.parentNavigationController = self.navigationController
        controllerArray.append(controller3)
        
        var controller4 : DealListTableViewController = DealListTableViewController(nibName: "DealListTableViewController", bundle: nil)
        controller4.title = "Fashion"
        controller4.parentNavigationController = self.navigationController
        controllerArray.append(controller4)
        
        var controller5 : DealListTableViewController = DealListTableViewController(nibName: "DealListTableViewController", bundle: nil)
        controller5.title = "Gadgets"
        controller5.parentNavigationController = self.navigationController
        controllerArray.append(controller5)
        
        // Customize menu (Optional)
        var parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .BottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .SelectionIndicatorColor(Constants.Colors.DealdeyGreen),
            .MenuMargin(20.0),
            .MenuHeight(40.0),
            .SelectedMenuItemLabelColor(Constants.Colors.DealdeyGreen),
            .UnselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
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
}