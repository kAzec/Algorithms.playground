extension BinaryInteger {
    var isPowerOfTwo: Bool {
        if self <= 0 {
            return false
        } else if self == 1 {
            return true
        } else {
            var n = self
            
            while n % 2 == 0 {
                n /= 2
            }
            
            return n == 1
        }
    }
    
    var isPowerOfTwo2: Bool {
        if self <= 0 {
            return false
        } else {
            return self & (self - 1) == 0
        }
    }
}

extension Int {
    var isPowerOfTwo3: Bool {
        return (self > 0) && (4611686018427387904 % self == 0)
    }
}

2.isPowerOfTwo
2.isPowerOfTwo2
2.isPowerOfTwo3
4.isPowerOfTwo
4.isPowerOfTwo2
4.isPowerOfTwo3
5.isPowerOfTwo
5.isPowerOfTwo2
5.isPowerOfTwo3
11.isPowerOfTwo
11.isPowerOfTwo2
11.isPowerOfTwo3
