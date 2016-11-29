//
// Created by Sergey Suslov on 23.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Material

class ButtonActionUserUpdate: RaisedButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.layer.borderColor = UIColor.red.cgColor
        self.backgroundColor = Color.green.lighten1
        self.text("Update")
    }
}


