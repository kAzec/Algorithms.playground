
extension BinaryInteger {
    var isPrime: Bool {
        if self <= 1 {
            return false
        } else if self <= 3 {
            return true
        } else if self % 2 == 1 {
            var i: Self = 3
            
            while i * i <= self {
                if self % i == 0 {
                    return false
                }
                
                i += 2
            }
            
            return true
        } else {
            return false
        }
    }
}

1.isPrime
2.isPrime
3.isPrime
11.isPrime
1045527.isPrime
2097593.isPrime
