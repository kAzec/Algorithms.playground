
extension MutableCollection where Self : BidirectionalCollection {
    mutating func insertionSort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        for var i in indices {
            while i != startIndex {
                let j = index(before: i)
                
                if try areInIncreasingOrder(self[i], self[j]) {
                    swapAt(i, j)
                    i = j
                } else {
                    break
                }
            }
        }
    }
}

extension MutableCollection where Self : BidirectionalCollection, Element : Comparable {
    mutating func insertionSort() {
        insertionSort(by: <)
    }
}

var a = [10, 66, 27, 633, 74, 25]
let sorted = a.sorted()

a.insertionSort()

assert(a == sorted)
