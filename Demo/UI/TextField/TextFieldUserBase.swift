//
// Created by Sergey Suslov on 23.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Material

class TextFieldUserBase: TextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.keyboardAppearance = .dark
        self.isClearIconButtonEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init?(coder: aDecoder)
    }
}
