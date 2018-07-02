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
        if darkCircle.transform.isIdentity {
            UIView.animate(withDuration: 1, animations: {
                self.darkCircle.transform = CGAffineTransform(scaleX: 11, y: 11)
                self.menuView.transform = CGAffineTransform(translationX: 0, y: -45)
                self.toggleButton.transform = CGAffineTransform(rotationAngle: self.radians(degrees:180))
            }) { (true) in
                print("hi")
            }
        } else {
            UIView.animate(withDuration: 1, animations: {
                //everything goes back to original position and orientation :)
                self.darkCircle.transform = .identity
                self.menuView.transform = .identity
                self.toggleButton.transform = .identity
            }) { (true) in
                print("hi")
            }
        }
    }
    
    func radians(degrees: Double) -> CGFloat{
        return CGFloat(degrees * .pi / degrees)
    }
}
