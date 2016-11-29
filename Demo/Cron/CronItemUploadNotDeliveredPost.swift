//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyTimer

class CronItemUploadNotDeliveredPost: CronItemBase {
    override init() {
        super.init()
        self.interval = 10.second
        self.block = {
            ModelPost.postSendUndelivered()
        }
    }
}
