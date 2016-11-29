//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CellBase: UITableViewCell {
    var disposeBag = DisposeBag()
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
}