//
//  ViewController.swift
//  TMColor
//
//  Created by 汤天明 on 2019/5/9.
//  Copyright © 2019 汤天明. All rights reserved.
//

import UIKit
import MetalKit
class ViewController: UIViewController {

    var  backgroundColor = UIColor.init(rgba: 0xff753e)
    let colorView = UIView.init(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    let  inverseView = UIView.init(frame:CGRect(x: 200, y: 200, width: 200, height: 200))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = backgroundColor
        inverseView.backgroundColor = backgroundColor.inverseColor()
        self.view.addSubview(colorView)
        self.view.addSubview(inverseView)
        
       
         useWorkItem()
        
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = UIColor.randomColor()
        colorView.backgroundColor = backgroundColor
        inverseView.backgroundColor = backgroundColor.inverseColor()
        
      
    }
    
    
    func   interview(){
        
        print("task one!")
        
        let queue = dispatch_queue_concurrent_t.init(label: "myque",attributes:DispatchQueue.Attributes.concurrent)
        print("1,Thread \(Thread.current)")
        queue.async {
            print("2,Thread \(Thread.current)")
            queue.sync {
                print("3,Thread \(Thread.current)")
            }
            print("4,Thread \(Thread.current)")
        }
        print("5,Thread \(Thread.current)")
        
//        queue.activate()
    }
    
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
         print("first value = ", value)
        workItem.perform()
        
        let queue = DispatchQueue.global(qos: .utility)
         print(" second value = ", value)
        queue.async {
            workItem.perform()
            print(" third value = ", value)
        }
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) {
            print(" fifth value = ", value)
        }
        print(" forth value = ", value)
    }
}

