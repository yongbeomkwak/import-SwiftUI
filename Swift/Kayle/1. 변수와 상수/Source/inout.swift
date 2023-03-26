import UIKit
import Foundation

var a :Int = 3


func add(_ a: inout Int) {

    a = a + 3
}

func add2(_ a :Int){
    
    var aa:Int = a
    
    aa = aa + 3
    
}


add2(a)
add2(a)

print(a) // result: a = 3

add(&a)
add(&a)

print(a) //result: a = 9 (3+3+3)
