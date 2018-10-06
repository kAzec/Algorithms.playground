
extension Collection where Element : Equatable {
    var major: Element? {
        guard var candidate = first else {
            return nil
        }
        
        var counter = 1
        
        for element in dropFirst() {
            if counter == 0 {
                candidate = element
                counter = 1
            } else if element == candidate {
                counter += 1
            } else {
                counter -= 1
            }
        }
        
        counter = 0
        
        for element in self {
            if element == candidate {
                counter += 1
            } else {
                counter -= 1
            }
        }
        
        return counter >= 0 ? candidate : nil
    }
}

do {
    let arrays = [
        [1],
        [1, 1],
        [1, 2, 3, 4],
        [4, 3, 2, 2, 1],
        [8, 7, 1, 1, 4, 4, 6, 4, 4, 1, 4, 2, 4, 4, 4],
        [3, 3, 3, 3, 11, 921, 3, 3, 4, 5, 66, 3, 71, 41, 3, 51, 3]
    ]
    
    for a in arrays {
        if let major = a.major {
            assert(a.lazy.filter { $0 == major }.count >= a.count / 2)
        }
    }
}
