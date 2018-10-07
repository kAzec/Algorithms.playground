extension Array where Element == Int {
    mutating func sortColors() {
        var lo = 0, mi = 0, hi = count - 1
        
        var i = 0
        
        while mi <= hi {
            i += 1
            
            switch self[mi] {
            case 0:
                swapAt(lo, mi)
                lo += 1
                mi += 1
            case 1:
                mi += 1
            case 2:
                swapAt(hi, mi)
                hi -= 1
            default: break
            }
        }
        
        print(i)
    }
    
    mutating func sortColors2() {
        var n0 = -1, n1 = -1, n2 = -1
        
        for v in self {
            switch v {
            case 0:
                n2 += 1; n1 += 1; n0 += 1
                self[n2] = 2; self[n1] = 1; self[n0] = 0
            case 1:
                n2 += 1; n1 += 1
                self[n2] = 2; self[n1] = 1
            case 2:
                n2 += 1
                self[n2] = 2
            default: continue
            }
        }
    }
}



//do {
//    var a = [1, 2, 0]
//    a.sortColors()
//}

do {
    var a = [2, 0, 1, 2, 1, 2, 1, 1, 2, 2, 0, 0, 1, 2, 0, 2, 1, 1, 0]
    a.sortColors()
}

do {
    var a = [2,0,2,1,1,0]
    a.sortColors2()
    assert(a == [0, 0, 1, 1, 2, 2])
}
