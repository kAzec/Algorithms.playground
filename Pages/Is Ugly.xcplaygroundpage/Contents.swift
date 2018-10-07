extension BinaryInteger {
    var isUgly: Bool {
        if self <= 0 {
            return false
        } else if self == 1 {
            return true
        } else {
            var n = self
            
            while n % 2 == 0 {
                n /= 2
            }
            
            while n % 3 == 0 {
                n /= 3
            }
            
            while n % 5 == 0 {
                n /= 5
            }
            
            return n == 1
        }
    }
}

1.isUgly
3.isUgly
6.isUgly
7.isUgly
10.isUgly
14.isUgly
