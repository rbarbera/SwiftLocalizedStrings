/*: 

[Previous](@previous)

On our previous approach we have an explicit protocol implementation that we should copy to each of our `enum`s, making the code very repetitive
*/

import Foundation

enum Options : String { case Some }
enum Login: String { case Name }

extension Options: CustomStringConvertible {
    var description : String  {
        let tableName = "\(self.dynamicType)"
        return NSLocalizedString(self.rawValue, tableName: tableName, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

extension Login: CustomStringConvertible {
    var description : String  {
        let tableName = "\(self.dynamicType)"
        return NSLocalizedString(self.rawValue, tableName: tableName, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

/*:
We have here a severe case of code duplication, a very bad code smell. We can do it better by using protocol extensions introduced in **Swift 2.0**. This will allow us to provide a default implementation.
First, let define a very simple custom protocol: we only add a phantom protocol that is just `CustomStringConvertible` with other hat
*/

protocol LocalizedEnum : CustomStringConvertible {}

/*:
With this special case for the `CustomStringConvertible` protocol, we can especialize it. We need to apply it only to `enum`s which has rawValue. And we need to ensure that this RawValue is a `String`.
Thankfully _there is a protocol for this_ in the standard library. This protocol is `RawRepresentable`. With this little protocol in hand, we can write our extension to give a default implementation to our phantom protocol:
*/

class BundleMarker {}

extension LocalizedEnum where Self: RawRepresentable, Self.RawValue == String {
    var description : String  {
        let tableName = "\(self.dynamicType)"
        let bundle =  NSBundle(forClass: BundleMarker.self)
        return NSLocalizedString(self.rawValue, tableName: tableName, bundle: bundle, value: "", comment: "")
    }
}

/*:
That's all!. Now each enum with `String` as rawValue that conforms the `LocalizedEnum` protocol will have *automagical* localization
*/

enum Swift: String, LocalizedEnum {
    case Awesome
    case Magic
    case Powerful
}

print(Swift.Awesome)
print(Swift.Magic)
print(Swift.Powerful)
print(Swift.Powerful.rawValue)
