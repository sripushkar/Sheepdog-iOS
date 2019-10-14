//
//  HomeController.swift
//  Sheepdog-iOS
//
//  Created by Sri Julapally on 10/9/19.
//  Copyright © 2019 Sri Julapally. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        // other stuff goes here
    }
    
    func configureViewComponents(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "065 Burning Spring.png")!)
        navigationController?.navigationBar.isHidden = true
    }
    
}
