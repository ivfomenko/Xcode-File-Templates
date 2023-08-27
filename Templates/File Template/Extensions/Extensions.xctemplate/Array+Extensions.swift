import Foundation

// MARK: - Array
public extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

// MARK: - Array where Element: Equatable
public extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `element`:
    mutating func remove(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}

// MARK: - Array where Element: BinaryInteger
public extension Array where Element: BinaryInteger {

    /// The average value of all the items in the array
    var average: Int {
        if self.isEmpty {
            return 0
        } else {
            let sum = self.reduce(0, +)
            return Int(Double(sum) / Double(self.count))
        }
    }
}

// MARK: - Array where Element == CGFloat
public extension Array where Element == CGFloat {
    
    func difference(with array: [CGFloat]) -> [Bool] {
        guard self.count == array.count else { return [] }
        
        var difference = [Bool]()
        
        for (i, element) in self.enumerated() {
            difference.append(element == array[i])
        }
        
        return difference
    }
}

// MARK: - Array where Element: Hashable
public extension Array where Element: Hashable {
    
    /// difference between Hashable elements
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
