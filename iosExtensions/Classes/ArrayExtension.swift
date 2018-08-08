

//  
//
//  Created by Islam Elshazly on 8/2/17.
//  Copyright © 2017 islam elshazly. All rights reserved.


extension Array {
    mutating func move(from oldIndex: Int, to newIndex: Int) {
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }   
}
