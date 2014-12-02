//
//  TapPatch.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 12/1/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import UIKit

enum TapPatchInput: PatchInput {
        case View = "View"
}

enum TapPatchOuput: PatchOutput {
    case X = "X",
    Y = "Y",
    VelocityX = "VelocityX",
    VelocityY = "VelocityY"
}

class TapPatch: Patch {

    var tapGesture = UITapGestureRecognizer()

    override init(identifier: String) {
        super.init(identifier: identifier)

        tapGesture.addTarget(self, action: "gesture:")

        addInput(TapPatchInput.View.rawValue, updateView)
        addOutput(TapPatchOuput.X.rawValue)
        addOutput(TapPatchOuput.Y.rawValue)
        addOutput(TapPatchOuput.VelocityX.rawValue)
        addOutput(TapPatchOuput.VelocityY.rawValue)

    }

    func updateView(value: Any?) {
        if let view = value as? UIView {
            tapGesture.view?.removeGestureRecognizer(tapGesture)
            view.addGestureRecognizer(tapGesture)
        }
    }

    func gesture(gesture: UITapGestureRecognizer) {
        println("TOUCH")
    }

}
