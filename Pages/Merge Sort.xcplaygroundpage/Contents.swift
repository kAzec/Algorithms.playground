extension RangeReplaceableCollection {
    func mergeSorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Self {
        return try mergeSorted(within: startIndex..<endIndex, by: areInIncreasingOrder)
    }
    
    func mergeSorted(
        within range: Range<Index>,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Self {
        guard !range.isEmpty else {
            return Self()
        }
        
        let offset = distance(from: range.lowerBound, to: range.upperBound)
        
        guard offset > 1 else {
            var collection = Self()
            collection.append(self[range.lowerBound])
            return collection
        }
        
        guard offset > 2 else {
            return try mergeTwo(at: range.lowerBound, by: areInIncreasingOrder)
        }
        
        let middleOffset = offset / 2
        let suffixOffset = offset - middleOffset
        let middleIndex = index(range.lowerBound, offsetBy: middleOffset)
        
        return try Self.merge(
            try mergeSorted(within: range.lowerBound..<middleIndex, distance: middleOffset, by: areInIncreasingOrder),
            try mergeSorted(within: middleIndex..<range.upperBound, distance: suffixOffset, by: areInIncreasingOrder),
            by: areInIncreasingOrder
        )
    }
    
    private func mergeTwo(
        at startIndex: Index,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Self {
        var collection = Self()
        
        let first = self[startIndex]
        let second = self[index(after: startIndex)]
        
        if try areInIncreasingOrder(first, second) {
            collection.append(first)
            collection.append(second)
        } else {
            collection.append(second)
            collection.append(first)
        }
        
        return collection
    }
    
    private func mergeSorted(
        within subrange: Range<Index>,
        distance: Int,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Self {
        switch distance {
        case 1:
            var collection = Self()
            collection.append(self[subrange.lowerBound])
            return collection
        case 2:
            return try mergeTwo(at: subrange.lowerBound, by: areInIncreasingOrder)
        case let offset:
            let middleOffset = offset / 2
            let middleIndex = index(subrange.lowerBound, offsetBy: middleOffset)
            
            let subrange1 = subrange.lowerBound..<middleIndex
            let subrange2 = middleIndex..<subrange.upperBound
            
            return try Self.merge(
                try mergeSorted(within: subrange1, distance: middleOffset, by: areInIncreasingOrder),
                try mergeSorted(within: subrange2, distance: offset - middleOffset, by: areInIncreasingOrder),
                by:   areInIncreasingOrder
            )
        }
    }
    
    private static func merge(
        _ one: Self,
        _ other: Self,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Self {
        var iter1 = one.makeIterator()
        var iter2 = other.makeIterator()
        
        guard var v1 = iter1.next() else {
            return other
        }
        
        guard var v2 = iter2.next() else {
            return one
        }
        
        var result = Self()
        result.reserveCapacity(one.underestimatedCount + other.underestimatedCount)
        
        while true {
            if try areInIncreasingOrder(v1, v2) {
                result.append(v1)
                
                if let nv1 = iter1.next() {
                    v1 = nv1
                } else {
                    result.append(v2)
                    
                    while let nv2 = iter2.next() {
                        result.append(nv2)
                    }
                    
                    break
                }
            } else {
                result.append(v2)
                
                if let nv2 = iter2.next() {
                    v2 = nv2
                } else {
                    result.append(v1)
                    
                    while let nv1 = iter1.next() {
                        result.append(nv1)
                    }
                    
                    break
                }
            }
        }
        
        print((one: one, other: other, merged: result))
        
        return result
    }
}

extension RangeReplaceableCollection where Element : Comparable {
    func mergeSorted() -> Self {
        return mergeSorted(by: <)
    }
}

let a = [10, 66, 27, 633, 74, 25]
assert(a.mergeSorted() == a.sorted())

var s = "😎åteºtœ😊"
assert(s.mergeSorted() == String(s.sorted()))

let a2 = [677, 13]
a2.mergeSorted()
