Wolf
====

Wolf lets you define interfaces in terms of data flow, regardless of whether that data is to be displayed to the user or used in determining how to layout the interface.

## Using Patches

Just like how patches are stitched together to form something larger (a quilt), Patches in Wolf are connected to form interfaces.

### Adding inputs & outputs

Patches provide an interface to take input and produce output. These inputs & outputs take the form of [Publinks](http://github.com/gilesvangruisen/publinks), simple instances that connect two other objects with a publish/subscribe relationship. Inputs and outputs are usually added to a Patch in that Patch's initializer by calling `addInput(inputName: PatchInput, _ subscriptionBlock: SubscriptionBlock)` and `addOutput(outputName: PatchOutput)`.

Every Patch input or output has name which is simply a `String`. To make your Patch interface more intuitive, you can define an enumeration with available input or output names (Input enums should be separated from Output enums, see [TapPatch.swift](https://github.com/gilesvangruisen/Wolf/blob/master/Wolf/TapPatch.swift#L11-L18)).

### Accepting input

When you add an input with the aforementioned `addInput…`, you provide a `SubscriptionBlock` along with the input name. A `SubscriptionBlock` is a function that takes an optional `value` of `Any?` type and has no return, as defined in the [Publinks interface](https://github.com/gilesvangruisen/publinks/blob/master/src/Publink.swift#L8-L9). This `SubscriptionBlock` is run whenever new data is provided to the input. 

### Providing input

There are two main ways to provide data to a Patch input.

The first is by simply calling `publish(value: Any?)` on the publink itself. This should be your preferred method when you want to provide a static value to an input. You can access the publink with subscript notation. E.g. `someViewPatch.inputs[ViewPatchInput.X.rawValue]`.

The second is by calling `setInput(inputName: PatchInput, _ inputPublink: Publink)` and providing the `inputName` (`String` or enum `rawValue`) and an `inputPublink`. An input for `inputName` must already exist, or nothing will happen. When `setInput` is called, the `inputPublink` will receive a new subscription block, that is the same `SubscriptionBlock` that was passed to `addInput` when the input was first created. Because of the way publinks work, the subscription block will be called automatically if publink has ever published a value.

### Publishing output

Output is published from a Patch by calling `publish(value: Any?)` on one of that Patch's outputs. See [TapPatch](https://github.com/gilesvangruisen/Wolf/blob/master/Wolf/TouchPatch.swift#L44-L47) for an example of how output X & Y values are published whenever the input view receives a touch.

## Creating Patches

To create a custom `Patch`, first subclass `Patch` or any other pre-existing subclass of `Patch`.

### Defining available inputs and ouputs

It is best practice to use a String enumeration, named by combining your Patch name followed by "Input", to define input and output names. This makes it easier to determine available inputs and outputs when interacting with a Patch, without having to go back and forth to the Patch definition (Thanks to Xcode's badass autocompletion):

``` Swift
enum ViewPatchInput: String {
    case X = "X",
    Y = "Y", …
}

enum ViewPatchOutput: String {
    case View = "View", …
}
```

### Adding inputs and outputs

Override the initializer to add inputs and outputs to your custom Patch:

``` Swift
class ViewPatch: Patch {
    // Add inputs with a name and SubscriptionBlock
    addInput(ViewPatchInput.X.rawValue, updateX)
    addInput(ViewPatchInput.Y.rawValue, updateY)

    // Add outputs with just a name
    addOutput(ViewPatchOutput.View.rawValue)
}

```
