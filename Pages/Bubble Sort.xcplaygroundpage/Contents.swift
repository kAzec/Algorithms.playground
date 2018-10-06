// Average Case: O(n*n)
// Worst Case: O(n*n)
// Best Case: O(n)
// Auxiliary Space: O(1)
// Stable: YES
extension MutableCollection {
    mutating func bubbleSort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        let count = self.count
        
        guard count > 1 else {
            return
        }
        
        for n in 1..<count {
            var swapped = false
            var currentIndex = startIndex
            var nextIndex = currentIndex
            
            while distance(from: currentIndex, to: endIndex) > n {
                nextIndex = index(after: currentIndex)
                
                if try areInIncreasingOrder(self[nextIndex], self[currentIndex]) {
                    swapped = true
                    
                    swapAt(currentIndex, nextIndex)
                }
                
                currentIndex = nextIndex
            }
            
            if !swapped {
                break
            }
        }
    }
}

extension MutableCollection where Element : Comparable {
    mutating func bubbleSort() {
        bubbleSort(by: <)
    }
}

var a = [10, 66, 27, 633, 74, 25]
let sorted = a.sorted()

a.bubbleSort()

assert(a == sorted)
