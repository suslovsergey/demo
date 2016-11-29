//
// Created by Sergey Suslov on 23.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit

class TextFieldUserName: TextFieldUserBase {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.placeholder = "Name"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
