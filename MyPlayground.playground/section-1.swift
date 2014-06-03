// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, my name is "

var names = ["Jo", "John", "Jennifer", "Julie"]

var namesDict = ["Jo":"Teacher", "John":"Developer", "Jennifer":"Barista", "Julie":"Zoo Keeper"]

for name in names{
    
    var myName = str + name
}

for (key, value) in namesDict {
   
    var person = "Hello, \(key) is a \(value)"
}
