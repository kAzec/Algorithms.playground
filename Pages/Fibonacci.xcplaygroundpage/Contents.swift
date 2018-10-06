
func fibonacci(_ n: UInt) -> UInt {
    switch n {
    case 0: return 0
    case 1: return 1
    default:
        var fn: UInt = 0, fn1: UInt = 0, fn2: UInt = 1
        
        for _ in 2...n {
            fn = fn1 + fn2
            fn1 = fn2
            fn2 = fn
        }
        
        return fn
    }
}

fibonacci(0)
fibonacci(1)
fibonacci(2)
fibonacci(3)
