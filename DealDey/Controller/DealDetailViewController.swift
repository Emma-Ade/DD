
import UIKit
import SwiftyJSON
import MBProgressHUD

class DealDetailViewController: UIViewController, UIWebViewDelegate {

    let api = APINetworking()
    var deal:Deals?
    var hud: MBProgressHUD!
    var selectedDeal: Deals!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var short_title: UILabel!
    @IBOutlet weak var listPrice: UILabel!
    @IBOutlet weak var soldCount: UILabel!
    @IBOutlet weak var save: UILabel!
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var highlightWebView: UIWebView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleInPriceSection: UILabel!
    @IBOutlet weak var descriptionWebView: UIWebView!
    @IBOutlet weak var finePirntWebview: UIWebView!
    @IBOutlet weak var descriptionWebViewHeight: NSLayoutConstraint!
    @IBOutlet weak var finePrintsWebViewHeight: NSLayoutConstraint!
    @IBOutlet weak var highlightsWebViewHeight: NSLayoutConstraint!
    @IBOutlet weak var timerLabel: UILabel!
    var count = 0;
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        if let dealId = deal?.id{
            
            self.short_title.text   = " \(self.deal!.shortTitle)"
            self.titleInPriceSection.text = self.deal?.shortTitle
            self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
      
            self.fetchDealDetails(dealId)
        }

    }
    
    private func fetchDealDetails(dealId: Int){
        
        let parameters = ["access_key" : "android-testing"]
        api.fetchRequest(Constants.Url.Deals+"\(dealId)" , params: parameters){
            (response) in
        
            self.selectedDeal = Deals.DealDetailsFromJSON(response["deal"] as! NSDictionary)
            self.loadDetailView()
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let urlString = self.deal?.image {
            
            if let escapedUrlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
                
                var imgURL: NSURL = NSURL(string: escapedUrlString)!
                dealImage.hnk_setImageFromURL(imgURL)
            }
        }
    }
    

    func webViewDidFinishLoad(webView: UIWebView) {
        
        let webViewtHeight : NSString = webView.stringByEvaluatingJavaScriptFromString("document.height")!
        let height = CGFloat((webViewtHeight).floatValue)
        
        switch(webView){
            
        case highlightWebView:
            self.highlightsWebViewHeight.constant = height
        case finePirntWebview:
            self.finePrintsWebViewHeight.constant = height
        case descriptionWebView:
            self.descriptionWebViewHeight.constant = height
        default:
            break;
        
        }
    }

    
    private func loadDetailView() {
        
        self.hud.hide(true)
        
        self.soldCount.text     = "\(self.selectedDeal.boughtCount!)"
        self.listPrice.text     = "₦\(self.selectedDeal.listingPrice)"
        self.save.text          = "₦\(self.selectedDeal.saving!)"
        self.discount.text      = "\(self.selectedDeal.percentageDiscount!)%"
        self.highlightWebView.loadHTMLString(self.selectedDeal.highlights, baseURL: nil)
        self.finePirntWebview.loadHTMLString(self.selectedDeal.highlights, baseURL: nil)
        self.descriptionWebView.loadHTMLString(self.selectedDeal.description, baseURL: nil)
        
        if selectedDeal.showTimer == true {
            
            self.count = selectedDeal.timeLeft!
            var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimerLabel"), userInfo: nil, repeats: true)

        }
    }
    
    
    private func timeLeft (seconds : Int) -> (Int, Int, Int, Int) {
        
        let days = (seconds / Constants.Time.SecondsInAHour)/Constants.Time.HoursInADay
        let hours = (seconds / Constants.Time.SecondsInAHour) % Constants.Time.HoursInADay
        let minutes = (seconds % Constants.Time.SecondsInAHour) / Constants.Time.SecondsInADay
        let seconds = (seconds % Constants.Time.SecondsInAHour) % Constants.Time.SecondsInADay
 
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


