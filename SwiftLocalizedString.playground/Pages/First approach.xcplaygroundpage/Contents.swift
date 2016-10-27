/*:

# NSLocalizedString from a Swift perspective

(*If you open the left panel, you can take a look at the Resources folder where you can find the string tables used on this Playground*)

After reading [this article](http://www.mhjaso.com/blog/otra-forma-de-lidiar-con-los-localizables-en-swift/) by Miguel Hernandez, I want to explore this issue from the point in which Miguel left it. I prefer a more direct approach where string translation where *automagical* managed without any trace of it in my code.

First difference: I use `String` as raw value and the fact that Swift 2.0 is able to generate raw values directly from the case labels.

*/

import UIKit

enum Options: String {
    case Cancel
    case Accept
    case New
    case LongOption = "This is a long string"
}


/*:
Now we can implement the `CustomStringConvertible` protocol to make transparent the translation process. We use a little trick here: `self.dynamicType` let us construct the translation table name from the enum's name, so we can remove one customization string.
*/

extension Options: CustomStringConvertible {
    var description : String  {
        let tableName = "\(type(of: self))"
        return NSLocalizedString(self.rawValue, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
    }
}

/*:
With this code in place you can use the enum *as usual* in your code and get the localized version.
*/

print(Options.LongOption)
print(Options.Cancel)
print(Options.New)

/*:
If at any point you need to access the no-translated value, it's available as rawValue
*/

print(Options.LongOption.rawValue)

/*:
But we can do it better [Next](@next)
*/



