import Foundation

public class BinaryTree<Element> {
    public var element: Element
    public var left, right: BinaryTree?
    
    public init(element: Element, left: BinaryTree? = nil, right: BinaryTree? = nil) {
        self.left = left
        self.right = right
        self.element = element
    }
}
