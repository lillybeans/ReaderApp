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
    @IBOutlet weak var card: IBInspectableView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    var cardOrigin: CGPoint!
    var rotationMultiplier : CGFloat!
    var verticalMultiplier: CGFloat!
    let verticalTranslation: CGFloat = 100
    var counter : Int = 0
    let titles = ["Broke", "Paper Craft", "Metamorphosis", "You Can't Blend In", "Seven Studies in Pop Piano"]
    let descriptions = ["Book for poor students", "Book for the artsy and creative", "Going through transformations", "When you were born to stand out!", "For Piano Enthusiasts"]
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotationMultiplier = radians(degrees:35) / (view.frame.width/2) //degrees of rotation PER pixel of movement in the x direction
        verticalMultiplier = verticalTranslation/(view.frame.width/2) //vertical translation per pixel of horizontal translation
        cardOrigin = card.center
        // Do any additional setup after loading the view.
        showNextCard()
    }

    @IBAction func toggleMenu(_ sender: Any) {
        if darkCircle.transform.isIdentity {
            UIView.animate(withDuration: 1, animations: {
                self.darkCircle.transform = CGAffineTransform(scaleX: 11, y: 11)
                self.menuView.transform = CGAffineTransform(translationX: 0, y: -50)
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
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) { //gets called everytime the card moves (even if for a tiny bit)
        let card = sender.view! //every gesture recognizer has a view
        let delta = sender.translation(in: card)
        card.center = CGPoint(x: cardOrigin.x + delta.x, y: cardOrigin.y + abs(delta.x)*verticalMultiplier)
        card.transform = CGAffineTransform(rotationAngle: delta.x*rotationMultiplier)
        
        if delta.x < 0 {
            thumbImageView.image = #imageLiteral(resourceName: "thumbs-down")
            thumbImageView.tintColor = .red
        } else {
            thumbImageView.image = #imageLiteral(resourceName: "thumbs-up")
            thumbImageView.tintColor = .green
        }
        
        thumbImageView.alpha = abs(delta.x)/view.center.x
        if sender.state == .ended{
            
            //check final position: if within 75 points to left or right margin, continue animating off the screen
            if card.center.x < 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x-300, y: card.center.y+self.verticalTranslation) //add some gravity
                    card.alpha = 0
                }) { (true) in
                    self.showNextCard()
                }
            } else if card.center.x  > (view.frame.width - 50){
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x+300, y: card.center.y+self.verticalTranslation) //add some gravity
                    card.alpha = 0
                }) { (true) in
                    self.showNextCard()
                }
            } else {
                //else restore original position
                UIView.animate(withDuration: 0.2) {
                    card.center = self.cardOrigin
                    self.thumbImageView.alpha = 0
                    card.transform = .identity
                }
            }

        }
    }
    
    func showNextCard(){
        counter = counter + 1
        if counter == 6 {
            counter = 1
        }
        
        //next book's data
        bookTitle.text = titles[counter-1]
        bookDescription.text = descriptions[counter-1]
        bookImageView.image = UIImage(named:"book\(counter)")
        
        //reset card
        self.card.center = self.cardOrigin
        self.thumbImageView.alpha = 0
        self.card.transform = .identity
        UIView.animate(withDuration: 0.2) {
            self.card.alpha = 1 //fade in
        }
    }
    
    func radians(degrees: Double) -> CGFloat{
        return CGFloat(degrees * .pi / 180)
    }
}
