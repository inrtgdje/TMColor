//
//  ViewController.swift
//  TMColor
//
//  Created by 汤天明 on 2019/5/9.
//  Copyright © 2019 汤天明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var  backgroundColor = UIColor.randomColor()
    let colorView = UIView.init(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    let  inverseView = UIView.init(frame:CGRect(x: 200, y: 200, width: 200, height: 200))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(colorView)
        self.view.addSubview(inverseView)
        
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = UIColor.randomColor()
        colorView.backgroundColor = backgroundColor
        inverseView.backgroundColor = backgroundColor.inverseColor()
    }
}

