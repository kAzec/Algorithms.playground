extension BinaryInteger {
    var isPowerOfThree: Bool {
        if self <= 0 {
            return false
        } else if self == 1 {
            return true
        } else {
            var n = self
            
            while n % 3 == 0 {
                n /= 3
            }
            
            return n == 1
        }
    }
}

extension Int {
    var isPowerOfThree2: Bool {
        return (self > 0) && (4052555153018976267 % self == 0)
    }
}

1.isPowerOfThree
3.isPowerOfThree
20.isPowerOfThree
27.isPowerOfThree
4052555153018976256.isPowerOfThree
