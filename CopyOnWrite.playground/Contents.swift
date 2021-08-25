/*:
# Copy on Write
 
 Demonstrates how Swift defers creating another array until a write causes a mutation.
 
 This example is lifted almost verbatim from Luciano Almeida's [Understanding Swift Copy-on-Write mechanisms](https://medium.com/@lucianoalmeida1/understanding-swift-copy-on-write-mechanisms-52ac31d68f2f).
*/

import Foundation

func addressString(_ o: UnsafeRawPointer ) -> String {
    return String(format: "%p", Int(bitPattern: o))
}


var a : NSMutableArray = [1,2,3]

print(a)


var array1 : [Int] = [0, 1, 2, 3]
var array2 = array1

array1
array2

var array3 : NSArray = [1,2,3]
array3

Unmanaged.passRetained(array3)

AnyObject


#if false

let x = Unmanaged.passRetained(array1)



// Print with just assign


let p1 = Int(bitPattern: UnsafeRawPointer(array1))
let p2 = Int(bitPattern: UnsafeRawPointer(array2))
assert(p1 == p2)
addressString(array1)
addressString(array2)
    
//Let's mutate array2 to see what's
array2.append(4)

addressString(array2)





#endif
