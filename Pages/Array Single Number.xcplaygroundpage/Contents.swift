
extension Array where Element == Int {
    var single: Int {
        var result = 0
        
        for i in self {
            result ^= i
        }
        
        return result
    }
}

do {
    assert([1, 2, 2, 1, 4].single == 4)
}
