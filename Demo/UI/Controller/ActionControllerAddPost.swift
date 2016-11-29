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

class ActionAddPostCell: ActionCell {
    let textView = TextViewActionAddPost(frame: .zero)
    let buttonSend = ButtonActionAddPostSend(frame: .zero)
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
        backgroundColor = .white

        self.sv(textView, buttonSend)

        buttonSend.height(40.0)

        self.layout(DefaultMetrics.spaceTop,
                |-DefaultMetrics.spaceLeft - textView - DefaultMetrics.spaceRight-|,
                DefaultMetrics.spaceDefault,
                |-DefaultMetrics.spaceLeft - buttonSend - DefaultMetrics.spaceRight-|,
                DefaultMetrics.spaceBottom)
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}



class ActionControllerAddPost: ActionControllerBase<ActionAddPostCell> {
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        cellSpec = .cellClass { _ in
            return 200
        }

        onConfigureCellForAction = { [weak self] cell, action, indexPath in
            cell.setup(action.data, detail: nil, image: nil)

            cell.buttonSend.rx.tap.bindNext({ _ in
                                      cell.textView.endEditing(true)
                                      let user = ModelStorage.user()
                                      ModelPost.post(cell.textView.text,
                                              name: user.name,
                                              userPicUrl: user.picUrl)
                                      self?.dismiss()
                                  }).addDisposableTo(cell.disposeBag)
            
            cell.textView.becomeFirstResponder()

        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
