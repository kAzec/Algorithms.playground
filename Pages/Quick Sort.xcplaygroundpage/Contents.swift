
extension MutableCollection {
    mutating func quickSort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        try quickSort(by: areInIncreasingOrder, in: startIndex..<endIndex)
    }
    
    mutating func quickSort(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        in range: Range<Index>
    ) rethrows {
        guard !range.isEmpty else {
            return
        }
        
        let nextIndex = index(after: range.lowerBound)
        
        guard nextIndex != range.upperBound else {
            return
        }
        
        let pivotIndex = try partition(
            by:   areInIncreasingOrder,
            from: range.lowerBound,
            next: nextIndex,
            to:   range.upperBound
        )
        
        try quickSort(by: areInIncreasingOrder, in: range.lowerBound..<pivotIndex)
        try quickSort(by: areInIncreasingOrder, in: index(after: pivotIndex)..<range.upperBound)
    }
    
    private mutating func partition(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        from startIndex: Index,
        next nextIndex: Index,
        to endIndex: Index
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
