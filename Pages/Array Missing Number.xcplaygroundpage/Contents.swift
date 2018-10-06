
extension Array where Element == Int {
    var missing: Int {
        let count = self.count
        var result = count * (count + 1) / 2
        
        for element in self {
            result -= element
        }
        
        return result
    }
}

do {
    assert([0, 1, 2, 3, 4, 6].missing == 5)
}
