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

        let viewPatch = ViewPatch()
        viewPatch.inputs[ViewPatchInput.Superview.rawValue]?.publish(self.view)
        viewPatch.inputs[ViewPatchInput.Width.rawValue]?.publish(100 as CGFloat)
        viewPatch.inputs[ViewPatchInput.Height.rawValue]?.publish(100 as CGFloat)
        viewPatch.inputs[ViewPatchInput.Color.rawValue]?.publish(UIColor.blueColor())

        let panPatch = PanPatch()
        panPatch.inputs[TapPatchInput.View.rawValue]?.publish(view)
        viewPatch.setInput(ViewPatchInput.CenterX.rawValue, panPatch.outputs[TapPatchOuput.X.rawValue]!)
        viewPatch.setInput(ViewPatchInput.CenterY.rawValue, panPatch.outputs[TapPatchOuput.Y.rawValue]!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

