
func findSubarrayLength(withMimumumSum minimumSum: Int, in numbers: [Int]) -> Int {
    guard !numbers.isEmpty else {
        return 0
    }
    
    var i = 0, sum = 0, ret = Int.max
    
    for (j, v) in numbers.enumerated() {
        sum += v
        
        while sum >= minimumSum {
            ret = min(ret, j - i + 1)
            sum -= numbers[i]
            i += 1
        }
    }
    
    return ret == .max ? 0 : ret
}

func findSubarrayLength2(withMinimumSum minimumSum: Int, in numbers: [Int]) -> Int {
    let count = numbers.count
    
    guard count > 0 else {
        return 0
    }
    
    var sums = [Int](repeating: 0, count: count + 1)
    
    for (i, n) in numbers.enumerated() {
        sums[i + 1] = sums[i] + n
    }
    
    if sums[count] < minimumSum {
        return 0
    }
    
    var ret = Int.max
    
    for i in 0..<count {
        var lo = i + 1, hi = count
        let s = sums[i] + minimumSum
        
        while lo <= hi {
            let mi = lo + (hi - lo) / 2
            
            if sums[mi] < s {
                lo = mi + 1
            } else {
                hi = mi - 1
            }
        }
        
        if lo == count + 1 {
            break
        }
        
        ret = min(ret, lo - i)
    }
    
    return ret
}

do {
    assert(findSubarrayLength(withMimumumSum: 20, in: [2,3,5,3,7,5,4,3,1]) == 4)
}

do {
    assert(dump(findSubarrayLength2(withMinimumSum: 20, in: [2,3,5,3,7,5,4,3,1])) == 4)
}
