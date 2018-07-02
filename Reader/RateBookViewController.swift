//
//  RateBookViewController.swift
//  Reader
//
//  Created by Lilly Tong on 2018-07-02.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

class RateBookViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var darkCircle: IBInspectableView!
    @IBOutlet weak var toggleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func toggleMenu(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.darkCircle.transform = CGAffineTransform(scaleX: 11, y: 11)
        }, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
    }
    
}
