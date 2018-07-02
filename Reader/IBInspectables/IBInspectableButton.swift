//
//  IBInspectableButton.swift
//  Reader
//
//  Created by Lilly Tong on 2018-07-02.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

@IBDesignable class IBInspectableButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 3 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var customBorderColor : UIColor = UIColor.red { //default is red
        didSet{
            layer.borderColor = customBorderColor.cgColor //must convert customBorderColor (our input, which is UIColor) to cgColor
        }
    }
    
    
}
