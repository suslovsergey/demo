//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Stevia
import UIKit
import XLActionController
import RxSwift
import RxCocoa
import RxGesture
import Material

class ActionControllerUserCell: ActionCell {
    let uiImageView = CustomUserPic(image: UIImage(named: "default")!)
    let uiUserPicUrl = TextFieldUserPicUrl(frame: .zero)
    let uiUserName = TextFieldUserName(frame: .zero)
    let uiButton = ButtonActionUserUpdate(frame: .zero)
    var disposeBag = DisposeBag()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    open override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    func initialize() {
        let user = ModelStorage.user()
        self.backgroundColor = .white

        uiUserName.text = user.name
        uiUserPicUrl.text = user.picUrl

        uiImageView.loadPic(user.picUrl)

        self.sv(uiImageView, uiUserPicUrl, uiUserName, uiButton)
        uiImageView.height(96.0).width(96.0).centerHorizontally()
        equalHeights(uiUserPicUrl, uiUserName)
        uiButton.height(50.0)
        self.layout(DefaultMetrics.spaceTop,
                uiImageView,
                DefaultMetrics.spaceTextField,
                |-DefaultMetrics.spaceLeft - uiUserName - DefaultMetrics.spaceRight-|,
                DefaultMetrics.spaceTextField,
                |-DefaultMetrics.spaceLeft - uiUserPicUrl - DefaultMetrics.spaceRight-|,
                >=0,
                |-DefaultMetrics.spaceLeft - uiButton - DefaultMetrics.spaceRight-|,
                DefaultMetrics.spaceBottom
        )


    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}


class ActionControllerUser: ActionControllerBase<ActionControllerUserCell> {

    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        cellSpec = .cellClass { _ in
            return 300
        }

        onConfigureCellForAction = { [weak self] cell, action, indexPath in
            cell.setup(action.data, detail: nil, image: nil)

            cell.uiUserPicUrl.rx.text.bindNext({
                                         guard let t = $0 else {
                                             return
                                         }
                                         if let _ = NSURL(string: t) {
                                             cell.uiImageView.loadPic(t)
                                         }
                                     }).addDisposableTo(cell.disposeBag)

            cell.uiButton.rx.tap.bindNext({ _ in
                                    ModelStorage.userUpdate(cell.uiUserName.text ?? "Anon", picUrl: cell.uiUserPicUrl.text ?? "")
                                    self?.dismiss()
                                }).addDisposableTo(cell.disposeBag)

        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
