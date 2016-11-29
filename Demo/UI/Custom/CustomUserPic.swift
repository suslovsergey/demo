//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit

class CustomUserPic: UIImageView {

    func loadPic(_ url: String) {
        ApiClient.image(url).then { [weak self] (image) -> Void in
                     self?.image = image
                 }
                 .catch {
                     Log.error($0)
                 }
    }
}
