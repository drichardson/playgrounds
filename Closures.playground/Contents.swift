/*:
 # Closures
 
 From [Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html) in the Swift Programming Language.
 
 
 Closure Expression Syntax
 
 ````
 { (parameters) -> return type in
    statements
 }
 ````
 */
//: ## Basics
let c1 = { () -> () in
    print("c1 called")
}
c1()
let c2 = { (s : String) -> Int in
    print("c2 called s=\(s)")
    return s.count
}
c2("hello");
//: ## Inferring Type from Context
let names = ["Sokka", "Aang", "Katara", "Zuko"]
//: Types may be specified explicitly using stanadard closure expression syntax.
names.sorted(by: { (s1 : String, s2 : String) in
    return s1 > s2
})
//: Types may be specified explicitly using stanadard closure expression syntax.
names.sorted(by: { (s1 : String, s2 : String) in
    return s1 > s2
})
//: However, all types (parametrs and return) can be inferred from names.sorted, so they can be omitted.
names.sorted( by: { (s1, s2) in
    return s1 > s2
})
//: Because all the types can be inferred, you can also omit the parentheses around parameters names and the return arrow.
names.sorted(by: { s1, s2 in
    return s1 > s2
})
//: Can also use shortand argument names.
names.sorted(by: { $0 > $1 })
//: Operator Methods
names.sorted(by: >)
/*:
 ## Trailing Closures
 If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, even though the trailing closure is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.
*/
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
    print("someFunctionThatTakesAClosure calling closure()")
    closure()
}
//: Here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
    print("trailing closure 1 called")
})
//: Here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
    print("trailing closure 2 called")
}
//: The sorted calls above can be rewritten using trailing closures.
let r1 = names.sorted() { $0 > $1 }
r1
//: Additionally, if the closure is the only argument and you write it as a trailing closure, you can omit the empty parenthesis.
let r2 = names.sorted { $0 > $1 }
r2
