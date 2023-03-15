func add(number: inout Int) {
    number += 1
}

var myNumber = 10
add(number: &myNumber) //레퍼런스 전달 
print(myNumber) //11 
