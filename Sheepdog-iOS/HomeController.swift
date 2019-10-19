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
    
    let WelcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "OR"
    label.textColor = UIColor(white: 1, alpha: 0.88)
    label.font = UIFont.systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        // other stuff goes here
    }

    
    
    func configureViewComponents(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "065 Burning Spring.png")!)
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(WelcomeLabel)
        WelcomeLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
