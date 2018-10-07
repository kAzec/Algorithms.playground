extension Array {
    mutating func remove(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var k = 0
        
        for i in indices {
            let element = self[i]
            
            if !(try predicate(element)) {
                self[k] = element
                k += 1
            }
        }
        
        return k
    }
}

var a = [0,1,2,2,3,0,4,2]
let n = a.remove(where: { $0 == 2 })

print((a, n))
