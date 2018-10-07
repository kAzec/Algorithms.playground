extension MutableCollection {
    mutating func heapSort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        try heapSort(in: startIndex..<endIndex, by: areInIncreasingOrder)
    }
    
    mutating func heapSort(
        in range: Range<Index>,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows {
        let n = self.distance(from: range.lowerBound, to: range.upperBound)
        
        guard n > 1 else {
            return
        }
        
        // 2i + 1 = n - 1, i = n / 2 - 1 when n is even
        // 2i + 2 = n - 1, i = (n - 1) / 2 - 1 = n / 2 - 1 when n is odd
        for i in stride(from: n / 2 - 1, through: 0, by: -1) {
            try heapify(at: index(range.lowerBound, offsetBy: i), in: range, by: areInIncreasingOrder)
        }
        
        for i in stride(from: n - 1, to: 0, by: -1) {
            let subrange = range.lowerBound..<index(range.lowerBound, offsetBy: i)
            swapAt(range.lowerBound, subrange.upperBound)
            try heapify(at: range.lowerBound, in: subrange, by: areInIncreasingOrder)
        }
    }
    
    private mutating func heapify(
        at rootIndex: Index,
        in range: Range<Index>,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows {
        let rootElement = self[rootIndex]
        
        var largestIndex = rootIndex
        var largestElement = rootElement
        
        if let leftChildIndex = leftChildIndex(forParentAt: rootIndex, in: range) {
            let leftChildElement = self[leftChildIndex]
            
            if try areInIncreasingOrder(largestElement, leftChildElement) {
                largestIndex = leftChildIndex
                largestElement = leftChildElement
            }
        }
        
        if let rightChildIndex = rightChildIndex(forParentAt: rootIndex, in: range) {
            let rightChildElement = self[rightChildIndex]
            
            if try areInIncreasingOrder(largestElement, rightChildElement) {
                largestIndex = rightChildIndex
                largestElement = rightChildElement
            }
        }
        
        if rootIndex != largestIndex {
            self[rootIndex] = largestElement
            self[largestIndex] = rootElement
            
            try heapify(at: largestIndex, in: range, by: areInIncreasingOrder)
        }
    }
    
    private func leftChildIndex(forParentAt parentIndex: Index, in range: Range<Index>) -> Index? {
        let offset = distance(from: startIndex, to: parentIndex)
        let childOffset = 2 * offset + 1
        return index(range.lowerBound, offsetBy: childOffset, lessThan: range.upperBound)
    }
    
    private func rightChildIndex(forParentAt parentIndex: Index, in range: Range<Index>) -> Index? {
        let offset = distance(from: startIndex, to: parentIndex)
        let childOffset = 2 * offset + 2
        return index(range.lowerBound, offsetBy: childOffset, lessThan: range.upperBound)
    }
    
    private func index(_ i: Index, offsetBy distance: Int, lessThan upperBound: Index) -> Index? {
        if let index = index(i, offsetBy: distance, limitedBy: upperBound), index != upperBound {
            return index
        } else {
            return nil
        }
    }
}

extension MutableCollection where Element : Comparable {
    mutating func heapSort() {
        heapSort(by: <)
    }
    
    mutating func heapSort(in range: Range<Index>) {
        heapSort(in: range, by: <)
    }
}

var a = [44, 103, 228, 31, 89, 11203, 1001, 1, 22, 4, 66, 27, 633, 8445, 1124, 74, 25]
let sorted = a.sorted()

a.heapSort()

assert(a == sorted)
