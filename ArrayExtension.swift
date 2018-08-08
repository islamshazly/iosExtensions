

//  
//
//  Created by Islam Elshazly on 8/2/17.
//  Copyright © 2017 islam elshazly. All rights reserved.


extension Array {
    mutating func move(from oldIndex: Int, to newIndex: Int) {
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
    
    
    
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in enumerated() {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if(index != nil) {
            self.remove(at: index!)
        }
    }
    
//    mutating func removeObject(object : AnyObject) {
//        for item in self {
//
//            let index = self.indexOfObject(object: object)
//            if index != nil {
//                self.remove(at: index!)
//            }
//        }
//    }
    
}
