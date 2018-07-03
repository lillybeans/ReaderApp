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
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var cardBehind: IBInspectableView!
    @IBOutlet weak var bookBehindDescription: UILabel!
    @IBOutlet weak var bookBehindImage: UIImageView!
    @IBOutlet weak var bookBehindTitle: UILabel!
    
    var cardOrigin: CGPoint!
    var rotationMultiplier : CGFloat!
    var verticalMultiplier: CGFloat!
    var opacityMultiplier: CGFloat!
    
    let verticalTranslation: CGFloat = 100
    var counter : Int = 0
    let titles = ["Broke", "Paper Craft", "Metamorphosis", "You Can't Blend In", "Seven Studies in Pop Piano"]
    let descriptions = ["Book for poor students", "Book for the artsy and creative", "Going through transformations", "When you were born to stand out!", "For Piano Enthusiasts"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotationMultiplier = radians(degrees:35) / (view.frame.width/2) //degrees of rotation PER pixel of movement in the x direction
        verticalMultiplier = verticalTranslation/(view.frame.width/2) //vertical translation per pixel of horizontal translation
        opacityMultiplier = 1/(view.frame.width/2-75) //increase in opacity per pixel of horizontal translation
        
        cardOrigin = card.center
        // Do any additional setup after loading the view.
        showNextCard()
        cardBehind.alpha = 0
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
        cardBehind.alpha = abs(delta.x*opacityMultiplier)
        
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
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x-300, y: card.center.y+self.verticalTranslation) //add some gravity
                    card.alpha = 0
                }) { (true) in
                    self.showNextCard()
                }
            } else if card.center.x  > (view.frame.width - 75){
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
                    self.cardBehind.alpha = 0
                }
            }

        }
    }
    
    func showNextCard(){
        
        //next book's data
        bookTitle.text = titles[counter]
        bookDescription.text = descriptions[counter]
        bookImageView.image = UIImage(named:"book\(counter+1)")
        
        //reset card
        self.card.center = self.cardOrigin
        self.thumbImageView.alpha = 0
        self.card.transform = .identity
        self.card.alpha = 1
  

        //reset next card (card behind)
        
        counter = counter + 1 //next image
        
        if counter == 5 {
            counter = 0
        }
        
        cardBehind.alpha = 0
        bookBehindTitle.text = titles[counter]
        bookBehindDescription.text = descriptions[counter]
        bookBehindImage.image = UIImage(named:"book\(counter+1)")
        
    }
    
    func radians(degrees: Double) -> CGFloat{
        return CGFloat(degrees * .pi / 180)
    }
}
