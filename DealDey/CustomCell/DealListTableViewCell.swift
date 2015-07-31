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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
