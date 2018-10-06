func findTwoSum(in numbers: [Int], sum: Int) -> (Int, Int) {
    guard numbers.count > 1 else {
        return (0, 0)
    }
    
    var lo = 0, hi = 1
    
    return (lo, hi)
}

func findTwoSumSorted(in numbers: [Int], sum: Int) -> (Int, Int) {
    var lo = 0, hi = numbers.count - 1
    
    while lo < hi {
        let s = numbers[lo] + numbers[hi]
        
        if s == sum {
            break
        } else if s < sum {
            lo += 1
        } else {
            hi -= 1
        }
    }
    
    return (lo, hi)
}

do {
    assert(findTwoSumSorted(in: [2, 7, 11, 15], sum: 18) == (1, 2))
}
