import Algorithms_Sources

func printReversely<Value>(_ node: Node<Value>) {
    if let next = node.next {
        printReversely(next)
    }
    
    print(node.value)
}

printReversely(Node<Int>([1, 22, 45, 6, 77, 102]))
