import Algorithms_Sources

extension Node {
    func reversed() -> Node {
        var current = next
        var previous = self
        
        while let c = current {
            current = c.next
            c.next = previous
            previous = c
        }
        
        next = nil
        
        return previous
    }
    
    func reversed2() -> Node {
        if let next = next {
            let nr = next.reversed2()
            next.next = self
            self.next = nil
            return nr
        } else {
            return self
        }
    }
}

do {
    let n0 = Node<Int>(0)
    let n1 = Node<Int>(1)
    let n2 = Node<Int>(2)
    let n3 = Node<Int>(3)
    let n4 = Node<Int>(4)
    
    let n = n0 += n1 += n2 += n3 += n4
    
    let nr = n.reversed()
    
    assert(nr === n4)
    assert(nr[1] === n3)
    assert(nr[2] === n2)
    assert(nr[3] === n1)
    assert(nr[4] === n0)
    assert(nr[4].next === nil)
}

do {
    let n = Node<Int>(0)
    assert(n.reversed() === n)
}

do {
    let n0 = Node<Int>(0)
    let n1 = Node<Int>(1)
    let n2 = Node<Int>(2)
    let n3 = Node<Int>(3)
    let n4 = Node<Int>(4)
    
    let n = n0 += n1 += n2 += n3 += n4
    let nr = n.reversed2()
    
    assert(nr === n4)
    assert(nr[1] === n3)
    assert(nr[2] === n2)
    assert(nr[3] === n1)
    assert(nr[4] === n0)
    assert(nr[4].next === nil)
}

do {
    let n = Node<Int>(0)
    assert(n.reversed2() === n)
}
