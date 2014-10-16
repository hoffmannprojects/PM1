//
//  ImpressumViewController.swift
//  PM1
//
//  Created by Moritz Kuentzler on 16/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import UIKit

class ImpressumViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}