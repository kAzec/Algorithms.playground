
import Algorithms_Sources

extension Node {
    func remove(at i: Int) -> Node {
        if i > 0 {
            var i = i
            var current = self
            
            while let next = current.next {
                i -= 1
                
                if i == 0 {
                    current.next = next.next
                    return next
                }
                
                current = next
            }
            
            fatalError("Index out of range.")
        } else if i < 0 {
            let previousNode = self[i - 1]
            let removed = previousNode.next!
            previousNode.next = removed.next
            return removed
        }
        
        fatalError("Index out of range.")
    }
    
    func removing(where predicate: (Value) throws -> Bool) rethrows -> Node? {
        var current = self
        var head, tail: Node?
        
        while true {
            if !(try predicate(current.value)) {
                if let t = tail {
                    t.next = current
                    tail = current
                } else {
                    head = current
                    tail = current
                }
            }
            
            if let next = current.next {
                current = next
            } else {
                break
            }
        }
        
        tail?.next = nil
        return head
    }
}

do {
    let n = Node<Int>([1, 2, 3, 4, 5])
    assert(n[-1].value == 5)
    assert(n[-2].value == 4)
    assert(n[-3].value == 3)
}

do {
    let n = Node<Int>([1, 2, 3, 4, 5])
    assert(n.remove(at: 1).value == 2)
    assert(n[0].value == 1)
    assert(n[1].value == 3)
    assert(n[2].value == 4)
    assert(n[3].value == 5)
}

do {
    let n = Node<Int>([1, 2, 3, 4, 5])
    assert(n.remove(at: -2).value == 4)
    assert(n.remove(at: -3).value == 2)
    assert(n[0].value == 1)
    assert(n[1].value == 3)
    assert(n[2].value == 5)
}

do {
    let n = Node<Int>([1, 1, 2, 3, 4, 4, 5])
    let rn = n.removing(where: { _ in true })
    
    assert(rn == nil)
}

do {
    let n = Node<Int>([1, 1, 2, 3, 4, 4, 5])
    let rn = n.removing(where: { _ in false })
    
    for (i, v) in [1, 1, 2, 3, 4, 4, 5].enumerated() {
        assert(rn?[i].value == v)
    }
}

do {
    let n = Node<Int>([1, 1, 2, 3, 4, 4, 5])
    let rn = n.removing(where: { (2..<4).contains($0) })
    
    for (i, v) in [1, 1, 4, 4, 5].enumerated() {
        assert(rn?[i].value == v)
    }
}

do {
    let n = Node<Int>([1, 1, 2, 3, 4, 4, 5])
    let rn = n.removing(where: { (1..<4).contains($0) })
    
    for (i, v) in [4, 4, 5].enumerated() {
        assert(rn?[i].value == v)
    }
}
