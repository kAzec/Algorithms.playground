import Foundation

extension BinaryInteger {
    var isPrimeLargerThan3: Bool {
        guard self % 2 == 1 else {
            return false
        }
        
        var i: Self = 3
        
        while i * i <= self {
            if self % i == 0 {
                return false
            }
            
            i += 2
        }
        
        return true
    }
}

func countPrimes(upTo n: Int) -> Int {
    if n > 3 {
        var count = 1
        
        for i in 3..<n {
            if i.isPrimeLargerThan3 {
                count += 1
            }
        }
        
        return count
    } else if n > 2 {
        return 1
    } else {
        return 0
    }
}

func countPrimes2(upTo n: Int) -> Int {
    if n > 3 {
        var i = 2
        var i2 = 4
        
        guard let table = calloc(n, 1)?.bindMemory(to: Bool.self, capacity: n) else {
            return 1
        }
        
        while i2 < n {
            if !table[i] {
                for j in stride(from: i2, to: n, by: i) {
                    (table + j).pointee = true
                }
            }
            
            i += 1
            i2 = i * i
        }
        
        var count = 2
        
        for i in 4..<n {
            if !table[i] {
                count += 1
            }
        }
        
        free(table)
        
        return count
    } else if n > 2 {
        return 1
    } else {
        return 0
    }
}

func countPrimes3(upTo n: Int) -> Int {
    guard n > 2 else {
        return 0
    }

    var i = 3
    var i2 = 9
    var count = n / 2
    var isPrime = ContiguousArray(repeating: true, count: n)

    while i2 < n {
        if isPrime[i] {
            var j = i2
            
            repeat {
                if isPrime[j] {
                    count -= 1
                    isPrime[j] = false
                }
                
                j += 2 * i
            } while j < n
        }
        
        i += 2
        i2 = i * i
    }

    return count
}

let n = 100
//countPrimes(upTo: n)
//countPrimes2(upTo: n)
countPrimes3(upTo: n)


// sqrt(n) <= n/2 -> n <= n^2/4 -> n^2 - 4n >= 0 -> n(n - 4) >= 0
