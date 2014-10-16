//
//  ScoreViewController.swift
//  PM1
//
//  Created by Moritz Kuentzler on 14/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var quiz: Quiz!
    
    //UI Outlets
    @IBOutlet weak var pointsRound0: UILabel!
    @IBOutlet weak var pointsRound1: UILabel!
    @IBOutlet weak var pointsRound2: UILabel!
    @IBOutlet weak var pointsRound3: UILabel!
    @IBOutlet weak var impressumButton: UIBarButtonItem!
    @IBOutlet weak var totalPointsImage: UIImageView!
    
    //UI Button Actions
    @IBAction func impressumButtonPressed(sender: UIBarButtonItem) {
        // Initialize and go to Impressum View
        let impressumView = self.storyboard?.instantiateViewControllerWithIdentifier("Impressum") as ImpressumViewController
        self.navigationController?.pushViewController(impressumView, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.title = "Ergebnis"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        setPointLabels()
        setTotalPointsImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPointLabels() {
        pointsRound0.text = "\(quiz.getPointsFromRound(0))"
        pointsRound1.text = "\(quiz.getPointsFromRound(1))"
        //pointsRound2.text = "\(quiz.getPointsFromRound(2))"
        //pointsRound3.text = "\(quiz.getPointsFromRound(3))"
    }
    
    func setTotalPointsImage() {
        switch quiz.getTotalPoints() {
        case 0:
            totalPointsImage.image = UIImage(named: "pfui.png")
        case 1:
            totalPointsImage.image = UIImage(named: "nicht_schlecht.png")
        case 2:
            totalPointsImage.image = UIImage(named: "dagehtnochwas.png")
        case 3:
            totalPointsImage.image = UIImage(named: "dagehtnochwas.png")
        case 4:
            totalPointsImage.image = UIImage(named: "BFF.png")
        case 5:
            totalPointsImage.image = UIImage(named: "unsterblicheliebe.png")
        case 6:
            totalPointsImage.image = UIImage(named: "seelenverwandt.png")
        default:
            totalPointsImage.image = UIImage(named: "pfui.png")
        }
    }
}