//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
extension Date {
    func toString(format fmt: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fmt
        return formatter.string(from: self)
    }
}
