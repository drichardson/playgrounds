/*:
 
 # Memory Safety
 Experiments related to [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) from the Swift Language Guide.
 
 Since these experiments cause errors, they are commented out. Uncomment them one by one to see what happens in each case.
 
 */
/*:
 ## Conflicting Access to In-Out Parameter
 The read and the write refer to the same location, producing a conflict.
 */
var stepSize = 1
func increment(_ number: inout Int) {
    number += stepSize
}
#if false
increment(&stepSize)
#else
//: FIX
// Make an explicit copy.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)
// update the original
stepSize = copyOfStepSize
#endif


//: Conflicting access also occur when passing a single variable as the argument for multiple in-out parameters.

func balance(_ x: inout Int, _ y : inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore) // OK
#if false
balance(&playerOneScore, &playerOneScore) // Error: inout arguments are not allowed to alias each other
#endif


/*:
 ## Conflicting Access to self in Methods
 */
struct Player {
    var name: String
    var health: Int
    var energy: Int

    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
#if false
oscar.shareHealth(with: &oscar)
// Error: conflicting accesses to oscar
#endif

/*:
 ## Conflicting Access to Properties
 
 A write access to the tuple element requires a write access to the entire tuple.
 */
var playerInformation = (health: 10, energy: 20)
#if false
balance(&playerInformation.health, &playerInformation.energy)
// Error: conflicting access to properties of playerInformation
#endif

/*:
 The code below shows that the same error appears for overlapping write accesses to the properties of a structure that’s stored in a global variable.
 */
var holly = Player(name: "Holly", health: 10, energy: 10)
#if false
balance(&holly.health, &holly.energy)  // Error
#endif
