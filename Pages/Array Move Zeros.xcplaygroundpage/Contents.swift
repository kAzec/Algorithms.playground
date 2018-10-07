extension Array where Element == Int {
    mutating func moveZeros() {
        var k = 0
        
        for i in indices where self[i] != 0 {
            swapAt(i, k)
            k += 1
        }
    }
}

do {
    var a = [0, 1, 0, 3, 12]
    a.moveZeros()
    
    assert(a == [1, 3, 12, 0, 0])
}
