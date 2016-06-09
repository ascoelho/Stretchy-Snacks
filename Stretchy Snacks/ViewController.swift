//
//  ViewController.swift
//  Stretchy Snacks
//
//  Created by Anthony Coelho on 2016-06-09.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var stackView: UIStackView = UIStackView()
    var snacksArray = [String]()
    var snackNames = [String]()
    var snacksTitleLabel = UILabel()
    
    
    
    var imageName1 = "oreos"
    let imageName2 = "pizza_pockets"
    let imageName3 = "pop_tarts"
    let imageName4 = "popsicle"
    let imageName5 = "ramen"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        snackNames = [imageName1, imageName2, imageName3, imageName4, imageName5]
        
        
        
        
        for imageName: String in snackNames {
            let imageView: UIImageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            let tap = UITapGestureRecognizer(target: self, action:#selector(ViewController.addSnack))
            imageView.addGestureRecognizer(tap)
            imageView.userInteractionEnabled = true
            stackView.addArrangedSubview(imageView)
  
        }
        
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.addSubview(stackView)
        
        stackView.heightAnchor.constraintEqualToConstant(100).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(navBarView.bottomAnchor, constant: -10).active = true
        stackView.leftAnchor.constraintEqualToAnchor(navBarView.leftAnchor, constant: 10).active = true
        stackView.rightAnchor.constraintEqualToAnchor(navBarView.rightAnchor, constant: -10).active = true
        
        stackView.hidden = true
        
        snacksTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        navBarView.addSubview(snacksTitleLabel)
        snacksTitleLabel.text = "SNACKS"
        snacksTitleLabel.frame = CGRect(origin: navBarView.bounds.origin, size: navBarView.bounds.size)

        snacksTitleLabel.centerXAnchor.constraintEqualToAnchor(navBarView.centerXAnchor, constant: 0).active = true
        snacksTitleLabel.centerYAnchor.constraintEqualToAnchor(navBarView.centerYAnchor, constant: 10).active = true
      
        




        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSnacks(sender: UIButton) {
        
        
        
        self.navBarHeightConstraint.constant = (self.navBarHeightConstraint.constant == 66 ? 200 : 66)
        

        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
                self.view.layoutIfNeeded()
                sender.transform = (atan2(sender.transform.b, sender.transform.a) == CGFloat(0) ? CGAffineTransformMakeRotation(CGFloat(M_PI_4)): CGAffineTransformMakeRotation(CGFloat(0)))
                self.stackView.hidden = self.stackView.hidden ? false : true
                self.snacksTitleLabel.text = self.snacksTitleLabel.text == "SNACKS" ? "Add a snack" : "SNACKS"
                self.snacksTitleLabel.transform = (atan2(sender.transform.b, sender.transform.a) == CGFloat(0) ? CGAffineTransformMakeTranslation( 0.0, 0.0 ) : CGAffineTransformMakeTranslation( 0.0, -30.0))
            
        }), completion: {
            (value: Bool) in
            
        })

    }
    
    func addSnack(recognizer:UITapGestureRecognizer) {
        
        self.snacksArray.append(self.snackNames[self.stackView.subviews.indexOf(recognizer.view!)!])
        
        UIView.transitionWithView(self.tableView,
                                  duration: 0.35,
                                  options: .TransitionCrossDissolve,
                                  animations:
            { () -> Void in
                self.tableView.reloadData()
            },
                                  completion: nil);
    
      
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.snacksArray.count;
    }


    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        cell.textLabel?.text = self.snacksArray[indexPath.row]
        
        return cell
    }

}

