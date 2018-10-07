import Algorithms_Sources

extension BinaryTree {
    func convertToDoublyLinkedList() -> (head: BinaryTree, tail: BinaryTree) {
        switch (left, right) {
        case (let l?, let r?):
            let leftList = l.convertToDoublyLinkedList()
            let rightList = r.convertToDoublyLinkedList()
            
            leftList.tail.right = self
            rightList.head.left = self
            
            self.left = leftList.tail
            self.right = rightList.head
            
            return (leftList.head, rightList.tail)
        case (let l?, nil):
            let leftList = l.convertToDoublyLinkedList()
            leftList.tail.right = self
            self.left = leftList.tail
            
            return (leftList.head, self)
        case (nil, let r?):
            let rightList = r.convertToDoublyLinkedList()
            rightList.head.left = self
            self.right = rightList.head
            
            return (self, rightList.tail)
        case (nil, nil):
            return (self, self)
        }
    }
}

// 2 -> 6 -> 7
// |    |
// v    v
// 1    4 -> 5
// |    |
// v    v
// 0    3
let tree: BinaryTree<Int> = {
    let trees = (0..<8).map { BinaryTree(element: $0) }
    trees[2].left = trees[1]
    trees[2].right = trees[6]
    trees[1].left = trees[0]
    trees[6].left = trees[4]
    trees[6].right = trees[7]
    trees[4].left = trees[3]
    trees[4].right = trees[5]
    
    return trees[2]
}()

dump(tree.convertToDoublyLinkedList().head)
