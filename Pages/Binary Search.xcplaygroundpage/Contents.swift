
extension Collection where Element : Comparable, Index == Int {
    func search(for element: Element) -> Int {
        return search(for: element, in: 0..<endIndex)
    }
    
    func search(for element: Element, in range: Range<Int>) -> Int {
        var lo = range.lowerBound, hi = range.upperBound - 1
        
        while lo <= hi {
            let middle = lo + (hi - lo) / 2
            let current = self[middle]
            
            if current == element {
                return middle
            } else if current < element {
                lo = middle + 1
            } else {
                hi = middle - 1
            }
        }
        
        return -1
    }
}

[10, 28, 33, 40, 44, 51, 75, 100].search(for: 32)
