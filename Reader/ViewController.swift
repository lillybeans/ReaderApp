//
//  ViewController.swift
//  Reader
//
//  Created by Lilly Tong on 2018-07-02.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        bgImageView.alpha = 0
        titleLabel.alpha = 0
        descLabel.alpha = 0
        startButton.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.bgImageView.alpha = 1
        }) { (true) in
            self.showTitle()
        }
    }
    
    @IBAction func startTapped(_ sender: Any) {
        performSegue(withIdentifier: "rateBooksSegue", sender: self)
    }
    
    func showTitle(){
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.alpha = 1
        }) { (true) in
            self.showDesc()
        }
    }
    
    func showDesc(){
        UIView.animate(withDuration: 0.1, animations: {
            self.descLabel.alpha = 1
        }) { (true) in
            self.showButton()
        }
    }
    
    func showButton(){
        UIView.animate(withDuration: 0.1) {
            self.startButton.alpha = 1
        }
    }
    



}

