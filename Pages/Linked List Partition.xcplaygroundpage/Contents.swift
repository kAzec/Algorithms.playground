import Algorithms_Sources

extension Node {
    func partitioned(by belongsToSecondPartition: (Value) throws -> Bool) rethrows -> Node {
        guard var current = next else {
            return self
        }
        
        var first, second: (head: Node, tail: Node)?
        
        if try belongsToSecondPartition(value) {
            second = (self, self)
        } else {
            first = (self, self)
        }
        
        while true {
            if try belongsToSecondPartition(current.value) {
                if let s = second {
                    s.tail.next = current
                    second = (s.head, current)
                } else {
                    second = (current, current)
                }
            } else {
                if let f = first {
                    f.tail.next = current
                    first = (f.head, current)
                } else {
                    first = (current, current)
                }
            }
            
            if let next = current.next {
                current = next
            } else {
                break
            }
        }
        
        switch (first, second) {
        case (let first?, let second?):
            first.tail.next = second.head
            second.tail.next = nil
            return first.head
        case (let first?, nil):
            return first.head
        case (nil, let second?):
            return second.head
        default:
            return self
        }
    }
    
    func partitionOddEven() {
        guard let ehead = next, var current = ehead.next else {
            return
        }
        
        var isOdd = true
        var otail = self
        var etail = ehead
        
        while true {
            if isOdd {
                otail.next = current
                otail = current
            } else {
                etail.next = current
                etail = current
            }
            
            isOdd = !isOdd
            
            if let next = current.next {
                current = next
            } else {
                break
            }
        }
        
        otail.next = ehead
        etail.next = nil
    }
}

do {
    let n = Node<Int>([11, 2, 44, 35, 5, 61, 41])
    let np = n.partitioned(by: { $0 > 20 })
    
    for (i, v) in [11, 2, 5, 44, 35, 61, 41].enumerated() {
        assert(np[i].value == v)
    }
}

do {
    let n = Node<Int>([11, 2, 44, 35, 5, 61, 41])
    n.partitionOddEven()
    
    for (i, v) in [11, 44, 5, 41, 2, 35, 61].enumerated() {
        assert(n[i].value == v)
    }
}
