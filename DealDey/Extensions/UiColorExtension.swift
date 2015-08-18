//
//  UiColorExtension.swift
//  DealDey
//
//  Created by Babatunde Adeniyi on 8/11/15.
//  Copyright (c) 2015 Tinkona Technologies. All rights reserved.
//

import Foundation


extension UIColor {
    static func colorWithValue(#redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}