//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit

extension Array {
    subscript(safe index: Index) -> Iterator.Element? {
        if index >= self.count {
            return nil
        }
        return self[index]
    }
}
