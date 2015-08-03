//
//  DealDetailViewController.swift
//  DealDey
//
//  Created by JOHN on 6/23/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class DealDetailViewController: UIViewController, UIWebViewDelegate {

    var deal:Deals?
    var api = APIController()
    var tableView: UITableView!
    var hud: MBProgressHUD!
    var timer = NSTimer()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var short_title: UILabel!
    @IBOutlet weak var listPrice: UILabel!
    @IBOutlet weak var soldCount: UILabel!
    @IBOutlet weak var save: UILabel!
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var highLights: UILabel!
    @IBOutlet weak var finePrints: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var highlightWebView: UIWebView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleInPriceSection: UILabel!
    
    @IBOutlet weak var descriptionWebView: UIWebView!
    @IBOutlet weak var dealDetailsHeaderView: UIView!
    @IBOutlet weak var finePirntWebview: UIWebView!
    
    @IBOutlet weak var timerLabel: UILabel!
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Deal Detail"
        //self.tabBarController?.tabBar.hidden = true
    
        var deal_id = deal?.id
        self.short_title.text   = self.deal?.short_title
        self.titleInPriceSection.text = self.deal?.short_title
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        api.getDeal(deal_id!){
            (response) in
            self.loadDetailView(response)
            
        }
        
        dealDetailsHeaderView.addBottomBorderWithHeight(1.0, color: UIColor.grayColor())
        shareButton.addLeftBorderWithWidth(1.0, color: UIColor.grayColor(), leftOffset: -3.0, topOffset: 0, bottomOffset: 0)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let urlString = self.deal?.image
        if let escapedUrlString = urlString!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {

            var imgURL: NSURL = NSURL(string: escapedUrlString)!
            dealImage.hnk_setImageFromURL(imgURL)
        }

    }
    

    func webViewDidFinishLoad(webView: UIWebView) {
        
      
        var webViewtHeight : NSString = webView.stringByEvaluatingJavaScriptFromString("document.height")!
        var constraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant:  CGFloat((webViewtHeight).floatValue))
        self.view.addConstraint(constraint)
      
    }

    
    private func loadDetailView(detail: NSDictionary) {
        
        var response      = detail["deal"] as! NSDictionary
        var highlights  = response["highlights"] as! String 
        var finePrints  = response["fine_prints"] as! String
        var description = response["description"] as! String
        var discountOff = response["percent_discount"] as? String ?? ""
        
        hud.hide(true)

        dispatch_async(dispatch_get_main_queue(), {
           
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            self.soldCount.text     = response["bought_count"]!.stringValue
            self.listPrice.text     = "₦"+response["list_price"]!.stringValue
            self.save.text          = "₦"+response["saving"]!.stringValue
            self.discount.text      = "\(discountOff)%"
            
            self.highlightWebView.loadHTMLString("<div style='font-size: 14px;'><p style='border-bottom: 1px solid gray;'> HighLights </p>"+highlights+"</div>", baseURL: nil)
            self.finePirntWebview.loadHTMLString("<div style='font-size: 14px;'><p style='border-bottom: 1px solid gray;'> Fine Prints </p>"+finePrints+"</div>", baseURL: nil)
            self.descriptionWebView.loadHTMLString("<div style='font-size: 14px !important;'><p style='border-bottom: 1px solid gray;'> Details </p>"+description+"</div>", baseURL: nil)
            
        
        })
        
        if response["show_timer"] as! Bool == true {
            
            self.count = response["time_left"] as! Int
            //println(response["time_left"] )
        }
      
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimerLabel"), userInfo: nil, repeats: true)
        
        
    }
    

    
    private func timeLeft (seconds : Int) -> (Int, Int, Int, Int) {
        
        var days = (seconds / 3600)/24
        var hours = (seconds / 3600) % 24
        var minutes = (seconds % 3600) / 60
        var seconds = (seconds % 3600) % 60
 
        
        return (days, hours, minutes, seconds)
    }
    
    
    
    func updateTimerLabel(){
        
        if self.count != 0 {
            
            var (d, h, m, s) = timeLeft(count)
            //println ("\(h) Hours, \(m) Minutes, \(s) Seconds")
            timerLabel.text = "\(d)D \(h)H \(m)M \(s)S"
            self.count -= 1
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


