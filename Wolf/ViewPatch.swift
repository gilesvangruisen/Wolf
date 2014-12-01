//
//  ViewPatch.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 11/25/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import UIKit

enum ViewPatchInput: String {
    case X = "X",
    Y = "Y",
    Width = "Width",
    Height = "Height",
    Superview = "Superview",
    Color = "Color"
}

class ViewPatch: Patch {

    var view = UIView()

    override init(identifier: String) {
        super.init(identifier: identifier)

        addInput("X", updateX)
        addInput("Y", updateY)
        addInput("Width", updateWidth)
        addInput("Height", updateHeight)
        addInput("Superview", updateSuperview)
        addInput("Color", updateColor)
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
