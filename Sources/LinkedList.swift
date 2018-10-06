
import Foundation

public final class Node<Value> {
    public var value: Value
    public var next: Node<Value>?
    
    public init(_ value: Value, next: Node<Value>? = nil) {
        self.value = value
        self.next = next
    }
    
    public convenience init(_ elements: [Value]) {
        switch elements.count {
        case 0:
            fatalError("Create linked-list from empty literal is not supported.")
        case 1:
            self.init(elements[0], next: nil)
        case let count:
            let next = Node(elements[1])
            var tail = next
            
            for i in 2..<count {
                let newTail = Node(elements[i])
                tail.next = newTail
                tail = newTail
            }
            
            self.init(elements[0], next: next)
        }
    }
    
    public subscript(i: Int) -> Node {
        if i == 0 {
            return self
        } else if i > 0 {
            var i = i
            var current = self
            
            while i > 0 {
                if let next = current.next {
                    current = next
                } else {
                    fatalError("Index out of range.")
                }
                
                i -= 1
            }
            
            return current
        } else {
            var i = i + 1
            var found: Node? = self
            var current = self
            
            while let next = current.next {
                current = next
                
                i += 1
                
                if i > 0 {
                    found = found!.next
                }
            }
            
            guard i >= 0, let f = found else {
                fatalError("Index out of range.")
            }
            
            return f
        }
    }
    
    public static func += (lhs: Node, rhs: Node) -> Node {
        lhs.next = rhs
        return lhs
    }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard var current = head else {
            return nil
        }
        
        var n = n
        var found: ListNode? = current
        
        while let next = current.next {
            current = next
            
            if n <= 0 {
                found = found!.next
            } else {
                n -= 1
            }
        }
        
        return head
    }
}
