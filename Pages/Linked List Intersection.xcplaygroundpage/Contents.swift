
import Algorithms_Sources

extension Node {
    var count: Int {
        var result = 1
        var current = self
        
        while let next = current.next {
            current = next
            result += 1
        }
        
        return result
    }
    
    func intersection(with other: Node) -> Node? {
        var n1 = self
        var n2 = other
        
        let c1 = n1.count
        let c2 = n2.count
        
        if c1 < c2 {
            for _ in 0..<(c2 - c1) {
                n2 = n2.next!
            }
        } else if c1 > c2 {
            for _ in 0..<(c1 - c2) {
                n1 = n1.next!
            }
        }
        
        if n1 === n2 {
            return n1
        }
        
        while let nn1 = n1.next, let nn2 = n2.next {
            if nn1 === nn2 {
                return nn1
            }
            
            n1 = nn1
            n2 = nn2
        }
        
        return nil
    }
    
    func intersection2(with other: Node) -> Node? {
        var n1: Node? = self, n2: Node? = other
        
        while n1 !== n2 {
            if let n = n1 {
                n1 = n.next
            } else {
                n1 = other
            }
            
            if let n = n2 {
                n2 = n.next
            } else {
                n2 = self
            }
        }
        
        return n1
    }
}

do {
    let c = Node<Int>(100)
    let n1 = Node<Int>(0) += Node<Int>(1) += Node<Int>(2) += c += Node<Int>(3) += Node<Int>(4) += Node<Int>(5)
    let n2 = Node<Int>(6) += Node<Int>(7) += Node<Int>(8) += Node<Int>(9) += Node<Int>(10) += c
    
    assert(n1.intersection(with: n2) === c)
}

do {
    let c = Node<Int>(100)
    let n1 = c += Node<Int>(0) += Node<Int>(1) += Node<Int>(2)
    let n2 = Node<Int>(6) += Node<Int>(7) += Node<Int>(8) += Node<Int>(9) += Node<Int>(10) += c += Node<Int>(11)
    
    assert(c.intersection(with: c) === c)
    assert(n2.intersection(with: c) === c)
    assert(n1.intersection(with: n2) === c)
}

do {
    let c = Node<Int>(100)
    let n1 = Node<Int>(0) += Node<Int>(1) += Node<Int>(2) += c += Node<Int>(3) += Node<Int>(4) += Node<Int>(5)
    let n2 = Node<Int>(6) += Node<Int>(7) += Node<Int>(8) += Node<Int>(9) += Node<Int>(10) += c
    
    assert(n1.intersection2(with: n2) === c)
}

do {
    let c = Node<Int>(100)
    let n1 = c += Node<Int>(0) += Node<Int>(1) += Node<Int>(2)
    let n2 = Node<Int>(6) += Node<Int>(7) += Node<Int>(8) += Node<Int>(9) += Node<Int>(10) += c += Node<Int>(11)
    
    assert(c.intersection2(with: c) === c)
    assert(n2.intersection2(with: c) === c)
    assert(n1.intersection2(with: n2) === c)
}
