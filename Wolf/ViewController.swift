//
//  ViewController.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 11/25/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewPatch = ViewPatch(identifier: "Untitled")
        viewPatch.inputs["Superview"]?.publish(self.view)
        viewPatch.inputs["X"]?.publish(0 as CGFloat)
        viewPatch.inputs["Y"]?.publish(0 as CGFloat)
        viewPatch.inputs["Width"]?.publish(100 as CGFloat)
        viewPatch.inputs["Height"]?.publish(100 as CGFloat)
        viewPatch.inputs["Color"]?.publish(UIColor.blueColor())

        let tapPatch = TapPatch(identifier: "1")
        tapPatch.inputs["View"]?.publish(viewPatch.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

