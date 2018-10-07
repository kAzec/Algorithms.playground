import Algorithms_Sources

extension Node where Value : Equatable {
    func deduplicate() {
        var current = self
        
        while let next = current.next {
            if next.value == current.value {
                current.next = next.next
            } else {
                current = next
            }
        }
    }
    
    func deduplicate2() -> Node? {
        var current = self
        var head, tail: Node?
        
        while true {
            var duplicated = false
            
            while let next = current.next, next.value == current.value {
                current = next
                duplicated = true
            }
            
            if !duplicated {
                if let t = tail {
                    t.next = current
                } else {
                    head = current
                }
                
                tail = current
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
    let n = Node<Int>([1, 1])
    n.deduplicate()

    assert(n[0].value == 1)
}

do {
    let n = Node<Int>([1, 2, 3, 3, 4, 4, 5])
    n.deduplicate()

    for (i, v) in [1, 2, 3, 4, 5].enumerated() {
        assert(n[i].value == v)
    }
}

do {
    let n = Node<Int>([1, 2])
    let dn = n.deduplicate2()!

    for (i, v) in [1, 2].enumerated() {
        assert(dn[i].value == v)
    }
}

do {
    let n = Node<Int>([1, 1])
    assert(n.deduplicate2() == nil)
}

do {
    let n = Node<Int>([1, 2, 2, 3, 3, 4, 4, 5])
    let dn = n.deduplicate2()!

    for (i, v) in [1, 5].enumerated() {
        assert(dn[i].value == v)
    }
}

do {
    let n = Node<Int>([1, 1, 2, 2])
    let dn = n.deduplicate2()
    assert(dn == nil)
}
