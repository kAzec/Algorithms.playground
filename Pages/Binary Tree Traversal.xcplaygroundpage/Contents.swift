
import Algorithms_Sources

extension BinaryTree {
    struct PreorderIterator : IteratorProtocol, Sequence {
        var node: BinaryTree?
        var stack: ContiguousArray<BinaryTree>
        
        init(tree: BinaryTree) {
            self.node = tree
            self.stack = ContiguousArray()
        }
        
        mutating func next() -> Element? {
            guard let current = node else {
                return nil
            }
            
            if let left = current.left {
                self.node = left
                
                if let right = current.right {
                    self.stack.append(right)
                }
            } else {
                self.node = current.right ?? stack.popLast()
            }
            
            return current.element
        }
    }
    
    struct InorderIterator : IteratorProtocol, Sequence {
        private var node: BinaryTree?
        private var stack: ContiguousArray<BinaryTree>
        
        init(tree: BinaryTree) {
            self.node = tree
            self.stack = ContiguousArray()
        }
        
        mutating func next() -> Element? {
            if var current = node {
                if var left = current.left {
                    while true {
                        stack.append(current)
                        current = left
                        
                        if let l = left.left {
                            left = l
                        } else {
                            break
                        }
                    }
                    
                    node = nil
                } else {
                    node = current.right
                }
                
                return current.element
            } else if let previous = stack.popLast() {
                node = previous.right
                return previous.element
            } else {
                return nil
            }
        }
    }
    
    struct PostorderIterator : IteratorProtocol, Sequence {
        private var node: BinaryTree?
        private var stack: ContiguousArray<BinaryTree>
        
        init(tree: BinaryTree) {
            self.node = tree
            self.stack = ContiguousArray()
        }
        
        mutating func next() -> Element? {
            if var current = node {
                while true {
                    if var left = current.left {
                        while true {
                            stack.append(current)
                            
                            if let l = left.left {
                                current = left
                                left = l
                            } else {
                                break
                            }
                        }
                        
                        node = current.right
                        return left.element
                    } else if let right = current.right {
                        stack.append(current)
                        current = right
                    } else {
                        node = nil
                        return current.element
                    }
                }
            } else if let last = stack.popLast() {
                if let prelast = stack.last, last === prelast.left {
                    node = prelast.right
                }
                
                return last.element
            } else {
                return nil
            }
        }
    }
    
    struct BreadthFirstIterator : IteratorProtocol, Sequence {
        private var head = 0
        private var queue = ContiguousArray<BinaryTree?>()
        
        init(tree: BinaryTree) {
            queue.append(tree)
        }
        
        mutating func next() -> Element? {
            guard head < queue.count, let current = queue[head] else {
                return nil
            }
            
            queue[head] = nil
            head += 1
            
            if let left = current.left {
                queue.append(left)
            }
            
            if let right = current.right {
                queue.append(right)
            }
            
            return current.element
        }
    }
    
    func traverseBreadthFirst(using block: (Element, Int) throws -> Void) rethrows {
        for i in 0... {
            if !(try traverseBreadthFirst(using: { try block($0, i) }, at: i)) {
                break
            }
        }
    }
    
    private func traverseBreadthFirst(using block: (Element) throws -> Void, at level: Int) rethrows -> Bool {
        if level <= 0 {
            try block(element)
            return left != nil || right != nil
        } else {
            switch (left, right) {
            case (let l?, let r?):
                let lstop = try l.traverseBreadthFirst(using: block, at: level - 1)
                let rstop = try r.traverseBreadthFirst(using: block, at: level - 1)
                
                return lstop || rstop
            case (let l?, nil):
                return try l.traverseBreadthFirst(using: block, at: level - 1)
            case (nil, let r?):
                return try r.traverseBreadthFirst(using: block, at: level - 1)
            default:
                return false
            }
        }
    }
}

// 0 -> 1 -> 3
// |    |
// v    v
// 2    4 -> 7
// |    |
// v    v
// 5    6
let tree: BinaryTree<Int> = {
    let trees = (0..<8).map { BinaryTree(element: $0) }
    trees[0].left = trees[1]
    trees[0].right = trees[2]
    trees[1].left = trees[3]
    trees[1].right = trees[4]
    trees[2].right = trees[5]
    trees[4].left = trees[6]
    trees[4].right = trees[7]
    
    return trees[0]
}()

do {
    assert(Array(BinaryTree<Int>.PreorderIterator(tree: tree)) == [0, 1, 3, 4, 6, 7, 2, 5])
}

do {
    assert(Array(BinaryTree<Int>.InorderIterator(tree: tree)) == [3, 1, 6, 4, 7, 0, 2, 5])
}

do {
    assert(Array(BinaryTree<Int>.PostorderIterator(tree: tree)) == [3, 6, 7, 4, 1, 5, 2, 0])
}

do {
    var result = [Int : [Int]]()
    
    tree.traverseBreadthFirst { element, level in
        result[level, default: []].append(element)
    }
    
    assert(result[0] == [0])
    assert(result[1] == [1, 2])
    assert(result[2] == [3, 4, 5])
    assert(result[3] == [6, 7])
}

do {
    assert(Array(BinaryTree<Int>.BreadthFirstIterator(tree: tree)) == [0, 1, 2, 3, 4, 5, 6, 7])
}
