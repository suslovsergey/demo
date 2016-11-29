//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import SwiftyTimer

class CronItemUpdatePosts: CronItemBase {
    override init() {
        super.init()
        self.interval = 10.second
        self.block = {
            Notify.send(NotifyLoadPostsStart.self)
            ModelPost.get()
                     .always {
                         Notify.send(NotifyLoadPostsStop.self)
                     }
                     .catch {
                         Log.error($0)
                     }
        }
    }

}

