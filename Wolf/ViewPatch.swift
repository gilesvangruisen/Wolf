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

        addInput("X")
        addInput("Y")
        addInput("Width")
        addInput("Height")
        addInput("Superview")
        addInput("Color")
    }

    override func setInput(inputName: String, newPublink: Publink) {
        super.setInput(inputName, newPublink: newPublink)

        switch inputName {

        case "X":
            println("Subscribing to X")
            newPublink.subscribeNamed(self.identifier, newSubscriptionBlock: updateX)
            break

        case "Y":
            println("Subscribing to Y")
            newPublink.subscribeNamed(self.identifier, newSubscriptionBlock: updateY)
            break

        case "Width":
            println("Subscribing to width")
            newPublink.subscribeNamed(self.identifier, newSubscriptionBlock: updateWidth)
            break

        case "Height":
            println("Subscribing to height")
            newPublink.subscribeNamed(self.identifier, newSubscriptionBlock: updateHeight)
            break

        case "Color":
            println("Subscribing to background")
            newPublink.subscribeNamed(self.identifier, newSubscriptionBlock: updateColor)
            break

        case "Superview":
            println("Subscribing to superview")
            newPublink.subscribeNamed(self.identifier, newSubscriptionBlock: updateSuperview)
            break

        default:
            break
        }
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
