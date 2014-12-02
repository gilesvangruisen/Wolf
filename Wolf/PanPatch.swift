//
//  PanPatch.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 12/1/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import UIKit

enum PanPatchInput: PatchInput {
    case View = "View"
}

enum PanPatchOuput: PatchOutput {
    case X = "X",
    Y = "Y",
    VelocityX = "VelocityX",
    VelocityY = "VelocityY"
}

class PanPatch: Patch {

    var tapGesture = UIPanGestureRecognizer()

    override init() {
        super.init()

        let selector: Selector = "gesture:"
        tapGesture.addTarget(self, action: selector)

        addInput(TapPatchInput.View.rawValue, updateView)

        addOutput(PanPatchOuput.X.rawValue)
        addOutput(PanPatchOuput.Y.rawValue)
        addOutput(PanPatchOuput.VelocityX.rawValue)
        addOutput(PanPatchOuput.VelocityY.rawValue)

    }

    func updateView(value: Any?) {
        if let view = value as? UIView {
            tapGesture.view?.removeGestureRecognizer(tapGesture)
            view.addGestureRecognizer(tapGesture)
        }
    }

    func gesture(recognizer: UIPanGestureRecognizer) {
        outputs[PanPatchOuput.X.rawValue]?.publish(recognizer.locationInView(recognizer.view!).x)
        outputs[PanPatchOuput.Y.rawValue]?.publish(recognizer.locationInView(recognizer.view!).y)
        outputs[PanPatchOuput.VelocityX.rawValue]?.publish(recognizer.velocityInView(recognizer.view!).x)
        outputs[PanPatchOuput.VelocityY.rawValue]?.publish(recognizer.velocityInView(recognizer.view!).y)
    }

}
