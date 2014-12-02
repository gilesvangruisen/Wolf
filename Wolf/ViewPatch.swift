//
//  ViewPatch.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 11/25/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import UIKit

enum ViewPatchInput: PatchInput {
    case X = "X",
    Y = "Y",
    CenterY = "Center Y",
    CenterX = "Center X",
    Width = "Width",
    Height = "Height",
    Superview = "Superview",
    Color = "Color"
}

enum ViewPatchOutput: PatchOutput {
    case View = "View"
}

class ViewPatch: Patch {

    var view = UIView()

    override init() {
        super.init()

        addInput(ViewPatchInput.X.rawValue, updateX)
        addInput(ViewPatchInput.Y.rawValue, updateY)
        addInput(ViewPatchInput.CenterX.rawValue, updateCenterX)
        addInput(ViewPatchInput.CenterY.rawValue, updateCenterY)
        addInput(ViewPatchInput.Width.rawValue, updateWidth)
        addInput(ViewPatchInput.Height.rawValue, updateHeight)
        addInput(ViewPatchInput.Superview.rawValue, updateSuperview)
        addInput(ViewPatchInput.Color.rawValue, updateColor)

        addOutput(ViewPatchOutput.View.rawValue)
        outputs[ViewPatchOutput.View.rawValue]?.publish(view)
    }

    func updateX(value: Any) {
        if let x = value as? CGFloat {
            view.frame = CGRectMake(x, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
        }
    }

    func updateY(value: Any) {
        if let y = value as? CGFloat {
            view.frame = CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height)
        }
    }

    func updateCenterX(value: Any) {
        if let x = value as? CGFloat {
            view.center.x = x
        }
    }

    func updateCenterY(value: Any) {
        if let y = value as? CGFloat {
            view.center.y = y
        }
    }

    func updateWidth(value: Any) {
        if let width = value as? CGFloat {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, view.frame.size.height)
        }
    }
    
    func updateHeight(value: Any) {
        if let height = value as? CGFloat {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)
        }
    }

    func updateSuperview(value: Any) {
        if let superview = value as? UIView {
            view.removeFromSuperview()
            superview.addSubview(view)
        }
    }

    func updateColor(value: Any) {
        if let color = value as? UIColor {
            view.backgroundColor = color
        }
    }

}
