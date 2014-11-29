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

    func removeInput(name: String) {
        if let input = inputs[name] {
            input.unsubscribe(name)
            inputs[name] = Publink()
        }
    }

    func subscribe(outputName: String, key: String, _ subscriptionBlock: SubscriptionBlock) {
        if let output = outputs[outputName] {
            output.subscribe(subscriptionBlock)
        }
    }

    func addInput(inputName: String) {
        inputs[inputName] = Publink()
        setInput(inputName, newPublink: Publink())
    }

    func setInput(inputName: String, newPublink: Publink) {
        if let input = inputs[inputName] {
            inputs[inputName] = newPublink
        }
    }

    func unsubscribe(outputName: String, key: String) {
        if let output = outputs[outputName] {
            output.unsubscribe(key)
        }
    }

    init(identifier: String) {
        self.identifier = identifier
    }

}