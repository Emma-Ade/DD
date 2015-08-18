//
//  FriendTableViewCell.swift
//  DealDey
//
//  Created by JOHN on 6/21/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import UIKit

class DealListTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var discountedPrice: UILabel!
    @IBOutlet weak var listPrice: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func prepareForReuse() {
        photoImageView.hnk_cancelSetImage()
        photoImageView.image = nil
    }
    
    
    class func loadCellForRow(indexPath: Int, deal: Deals, tableView: UITableView) -> UITableViewCell {
        
        let cell : DealListTableViewCell = tableView.dequeueReusableCellWithIdentifier("DealListTableViewCell") as! DealListTableViewCell
        
        cell.nameLabel.text = deal.shortTitle
        cell.discountedPrice.text = "₦\(deal.discountedPrice) "
        cell.location.setTitle("\( deal.hoverLocation!)", forState: UIControlState.Normal)
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "₦\(deal.listingPrice)")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.listPrice.attributedText = attributeString
        
        let urlString = deal.image
        if let escapedUrlString = urlString!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            let imgURL: NSURL = NSURL(string: escapedUrlString)!
            cell.photoImageView.hnk_setImageFromURL(imgURL)
            cell.activityIndicator.stopAnimating()
        }
        
        return cell
    }

}
