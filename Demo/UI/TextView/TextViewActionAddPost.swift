//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Material
class TextViewActionAddPost: UITextView {
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.isEditable = true

        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        self.tintColor = .black
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Color.grey.lighten1.cgColor
        self.layer.cornerRadius = 5.0
        self.keyboardAppearance = .dark
    }

}
