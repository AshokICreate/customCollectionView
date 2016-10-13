//
//  RootViewController.swift
//  oneMoreSample
//
//  Created by Ashok on 10/12/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var  secondViewControllerIdentifier = "secondViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: secondViewControllerIdentifier)
        
        addChildViewController(secondViewController)
        secondViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(secondViewController.view)
        secondViewController.didMove(toParentViewController: self)
    }

}
