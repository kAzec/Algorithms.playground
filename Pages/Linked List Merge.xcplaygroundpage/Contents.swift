
import Algorithms_Sources

extension Node where Value : Comparable {
    func merging(with other: Node) -> Node {
        var node1: Node
        var node2: Node
        
        if value < other.value {
            node1 = self
            node2 = other
        } else {
            node1 = other
            node2 = self
        }
        
        let head = node1
        var node = node1
        
        if let next1 = node1.next {
            node1 = next1
        } else {
            node1.next = node2
            return node1
        }
        
        while true {
            if node1.value < node2.value {
                node.next = node1
                node = node1
                
                if let next1 = node1.next {
                    node1 = next1
                } else {
                    node1.next = node2
                    break
                }
            } else {
                node.next = node2
                node = node2
                
                if let next2 = node2.next {
                    node2 = next2
                } else {
                    node2.next = node1
                    break
                }
            }
        }
        
        return head
    }
    
    func merging2(with other: Node) -> Node {
        let first: Node, second: Node
        
        if value < other.value {
            first = self
            second = other
        } else {
            first = other
            second = self
        }
        
        if let fnext = first.next {
            first.next = fnext.merging2(with: second)
        } else {
            first.next = second
        }
        
        return first
    }
}

do {
    let v1 = [22, 5, 10, 27, 100].sorted()
    let v2 = [1, 74, 81, 2, 4, 9].sorted()
    let n0 = Node<Int>(v1)
    let n1 = Node<Int>(v2)
    
    let m = n0.merging(with: n1)
    
    for (i, v) in (v1 + v2).sorted().enumerated() {
        assert(m[i].value == v)
    }
}

do {
    let n0 = Node<Int>(0)
    let n1 = Node<Int>(1)

    let m = n0.merging(with: n1)

    assert(m === n0)
    assert(m.next === n1)
}

do {
    let n0 = Node<Int>(0) += Node<Int>(3) += Node<Int>(4) += Node<Int>(6)
    let n1 = Node<Int>(1) += Node<Int>(2) += Node<Int>(5) += Node<Int>(7)

    let m = n0.merging(with: n1)

    for i in 0...7 {
        assert(m[i].value == i)
    }
}

do {
    let n0 = Node<Int>(1)
    let n1 = Node<Int>(0)

    let m = n0.merging2(with: n1)

    assert(m === n1)
    assert(m.next === n0)
}
