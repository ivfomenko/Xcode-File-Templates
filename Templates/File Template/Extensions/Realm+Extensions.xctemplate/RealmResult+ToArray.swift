import Foundation
import RealmSwift

// MARK: - Realm Results -> Array
public extension Results {
    // USE:
    // convert Realm Results<Object> to Array
    // you need write this ->
    // let objects = Realm().objects(YourType).toArray(YourType) as [YourType]
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

public extension Results {
    var array: [Element] {
        return Array(self)
    }
}
