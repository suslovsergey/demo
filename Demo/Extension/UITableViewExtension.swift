//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit

extension UITableView {
    func cell<T: UITableViewCell>(_ cls: T.Type) -> T {
        let ident = NSStringFromClass(cls)
        guard let cell = self.dequeueReusableCell(withIdentifier: ident) else {
            self.register(cls.self, forCellReuseIdentifier: ident)
            return self.cell(cls)
        }

        guard let castedCell = cell as? T else {
            return T(style: .default, reuseIdentifier: ident)
        }

        return castedCell
    }
}
