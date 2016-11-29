//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Stevia

class CellMain: CellBase {
    private let uiNameAndDate = LabelPostNameAndDate(frame: .zero)
    private let uiBody = LabelPostBody(frame: .zero)
    private let uiPic = CustomUserPic(image: UIImage(named: "default")!)
    private let avatarRadius: CGFloat = 32.0
    var body: String = "" {
        didSet {
            uiBody.text = body
        }
    }

    var nameAndDate: (name: String, date: Date) = (name: "", date: Date()) {
        didSet {
            uiNameAndDate.text = "\(nameAndDate.name ) at \(nameAndDate.date.toString(format: "dd.MM.yyyy / HH:mm:ss "))"
        }
    }

    var userPic: String = "" {
        didSet {
            if userPic.characters.count > 0 {
                uiPic.loadPic(userPic)
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.sv(uiNameAndDate, uiBody, uiPic)

        uiPic
                .height(avatarRadius)
                .width(avatarRadius)
                .centerVertically()
                .left(DefaultMetrics.spaceLeft)

        self.layout(DefaultMetrics.spaceTop,
                |-60 - uiNameAndDate - DefaultMetrics.spaceRight-|,
                |-60 - uiBody - DefaultMetrics.spaceRight-|,
                DefaultMetrics.spaceBottom
        )
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.uiPic.image = UIImage(named: "default")!
    }

}
