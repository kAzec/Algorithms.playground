
import Algorithms_Sources

extension Node {
    var isCyclic: Bool {
        guard var slow = next, var fast = slow.next else {
            return false
        }
        
        guard slow !== fast else {
            return true
        }
        
        while let s = slow.next, let f = fast.next?.next {
            if slow === fast {
                return true
            }
            
            slow = s
            fast = f
        }
        
        return false
    }
}

do {
    let n = Node<Int>(0) += Node<Int>(1) += Node<Int>(2) += Node<Int>(3) += Node<Int>(4) += Node<Int>(5)
    assert(!n.isCyclic)
    dump(n)
}

do {
    let c = Node<Int>(100)
    let n = Node<Int>(0) += Node<Int>(1) += Node<Int>(2) += c += Node<Int>(4) += c
    assert(n.isCyclic)
    dump(n)
}
