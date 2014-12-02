//
//  Patch.swift
//  Wolf
//
//  Created by Giles Van Gruisen on 11/28/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import Foundation

typealias PatchInput = String
typealias PatchOutput = String

class Patch: NSObject {

    /** The patch's input Publinks. */
    var inputs = [String: Publink]()

    /** The patch's output Publinks */
    var outputs = [String: Publink]()

    /** Add an input with name and publink */
    func addInput(inputName: PatchInput, _ subscriptionBlock: SubscriptionBlock) {
        if let currentInput = inputs[inputName] {
            currentInput.unsubscribe(subscriptionKey(self, inputName))
        }

        let newInput = Publink()
        inputs[inputName] = newInput
        newInput.subscribeNamed(subscriptionKey(self, inputName), subscriptionBlock)
    }

    func setInput(inputName: PatchInput, _ inputPublink: Publink) {
        if let input = inputs[inputName] {
            let subscriptionName = subscriptionKey(self, inputName)

            if let subscriptionBlock = input.namedSubscriptionBlocks[subscriptionName] {
                input.unsubscribe(subscriptionKey(self, inputName))
                inputPublink.subscribeNamed(subscriptionName, subscriptionBlock)
            }

            inputs[inputName] = inputPublink
        }
    }

    /** Remove input by name */
    func removeInput(name: PatchInput) {
        if let input = inputs[name] {
            input.unsubscribe(subscriptionKey(self, name))
            inputs[name] = Publink()
        }
    }

    /** Add output with name */
    func addOutput(name: PatchOutput) {
        outputs[name] = Publink()
    }

    /** Subscribe to output with patch */
    func subscribe(outputName: PatchOutput, _ patch: Patch, _ subscriptionBlock: SubscriptionBlock) {
        if let output = outputs[outputName] {
            output.subscribeNamed(subscriptionKey(patch, outputName), subscriptionBlock)
        }
    }

    /** Unsubscribe patch from output */
    func unsubscribe(outputName: PatchOutput, _ patch: Patch) {
        if let output = outputs[outputName] {
            output.unsubscribe(subscriptionKey(self, outputName))
        }
    }

    private func subscriptionKey(patch: Patch, _ publinkName: String) -> String {
        return "\(patch.description)-\(publinkName)"
    }

}
