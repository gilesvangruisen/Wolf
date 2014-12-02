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
    Y = "Y"
}

class TapPatch: Patch {

    var tapGesture = UITapGestureRecognizer()

    override init() {
        super.init()

        let selector: Selector = "gesture:"
        tapGesture.addTarget(self, action: selector)

        addInput(TapPatchInput.View.rawValue, updateView)

        addOutput(TapPatchOuput.X.rawValue)
        addOutput(TapPatchOuput.Y.rawValue)

    }

    func updateView(value: Any?) {
        if let view = value as? UIView {
            tapGesture.view?.removeGestureRecognizer(tapGesture)
            view.addGestureRecognizer(tapGesture)
        }
    }

    func gesture(recognizer: UITapGestureRecognizer) {
        outputs[TapPatchOuput.X.rawValue]?.publish(recognizer.locationInView(recognizer.view!).x)
        outputs[TapPatchOuput.Y.rawValue]?.publish(recognizer.locationInView(recognizer.view!).y)
    }

}
