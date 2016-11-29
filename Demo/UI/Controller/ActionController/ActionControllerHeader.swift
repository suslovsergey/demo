//
// Created by Sergey Suslov on 23.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import XLActionController
import Material
import Stevia

class ActionControllerHeader: UICollectionReusableView {
    let label = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.grey.lighten5

        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        self.sv(label)
        self.layout(DefaultMetrics.spaceTop, |-DefaultMetrics.spaceLeft - label - DefaultMetrics.spaceRight-|, DefaultMetrics.spaceBottom)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init?(coder: aDecoder)
    }
}
