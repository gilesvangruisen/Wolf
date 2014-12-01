//
//  Patch.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 11/28/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import Foundation


class Patch {

    /** The patch's unique identifier */
    var identifier: String

    /** The patch's input Publinks. */
    var inputs = [String: Publink]()

    /** The patch's output Publinks */
    var outputs = [String: Publink]()

    init(identifier: String) {
        self.identifier = identifier
    }

    /** Add an input with name and publink */
    func addInput(inputName: String, _ subscriptionBlock: SubscriptionBlock) {
        let input = Publink()
        inputs[inputName] = input
        input.subscribeNamed(self.identifier, subscriptionBlock)
    }

    /** Remove input by name */
    func removeInput(name: String) {
        if let input = inputs[name] {
            input.unsubscribe(identifier)
            inputs[name] = Publink()
        }
    }

    /** Subscribe to output with patch */
    func subscribe(outputName: String, patch: Patch, _ subscriptionBlock: SubscriptionBlock) {
        if let output = outputs[outputName] {
            output.subscribeNamed(patch.identifier, subscriptionBlock)
        }
    }

    /** Unsubscribe patch from output */
    func unsubscribe(outputName: String, patch: Patch) {
        if let output = outputs[outputName] {
            output.unsubscribe(patch.identifier)
        }
    }

}