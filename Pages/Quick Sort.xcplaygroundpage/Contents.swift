extension MutableCollection {
    mutating func quickSort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        try quickSort(in: startIndex..<endIndex, by: areInIncreasingOrder)
    }
    
    mutating func quickSort(
        in range: Range<Index>,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows {
        guard !range.isEmpty else {
            return
        }
        
        let nextIndex = index(after: range.lowerBound)
        
        guard nextIndex < range.upperBound else {
            return
        }
        
        let pivotIndex = try partition(
            from: range.lowerBound,
            next: nextIndex,
            to:   range.upperBound,
            by:   areInIncreasingOrder
        )
        
        try quickSort(in: range.lowerBound..<pivotIndex, by: areInIncreasingOrder)
        try quickSort(in: index(after: pivotIndex)..<range.upperBound, by: areInIncreasingOrder)
    }
    
    private mutating func partition(
        from startIndex: Index,
        next nextIndex: Index,
        to endIndex: Index,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Index {
        let pivot = self[startIndex]
        
        var i = index(after: nextIndex)
        var j = try areInIncreasingOrder(self[nextIndex], pivot) ? nextIndex : startIndex
        
        while i != endIndex {
            if try areInIncreasingOrder(self[i], pivot) {
                formIndex(after: &j)
                swapAt(i, j)
            }
            
            formIndex(after: &i)
        }
        
        swapAt(startIndex, j)
        
        return j
    }
}

extension MutableCollection where Self : BidirectionalCollection, Element : Comparable {
    mutating func quickSort() {
        quickSort(by: <)
    }
}

var a = [44, 103, 228, 31, 89, 11203, 1001, 1, 22, 4, 66, 27, 633, 8445, 1124, 74, 25]
let sorted = a.sorted()

a.quickSort()

assert(a == sorted)
