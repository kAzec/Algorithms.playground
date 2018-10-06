// Average Case: O(n*n)
// Worst Case: O(n*n)
// Best Case: O(n)
// Auxiliary Space: O(1)
// Stable: YES
extension MutableCollection {
    mutating func selectionSort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        for i in indices {
            var minimumIndex = i
            var j = index(after: i)
            
            while j != endIndex {
                if try areInIncreasingOrder(self[j], self[minimumIndex]) {
                    minimumIndex = j
                }
                
                formIndex(after: &j)
            }
            
            swapAt(i, minimumIndex)
        }
    }
}

extension MutableCollection where Element : Comparable {
    mutating func selectionSort() {
        selectionSort(by: <)
    }
}

var a = [10, 66, 27, 633, 74, 25]
let sorted = a.sorted()

a.selectionSort()

assert(a == sorted)
