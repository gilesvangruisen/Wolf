// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



var count = 0 as UInt32
let props = class_copyPropertyList(NSClassFromString("NSObject"), &count)

var properties = [objc_property_t]()
for i in 0...count - 1 {
    properties += [props[Int(i)]]
}

let propertyNames = properties.map { (property: objc_property_t) -> String in
    return String.fromCString(property_getName(property))!
}


println(propertyNames)


class Poo {
    func doo() {
        
    }
}