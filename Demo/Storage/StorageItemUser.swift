//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import RealmSwift

class StorageItemUser: Object {
    dynamic var id: Int64 = 1
    dynamic var name = "Anon"
    dynamic var picUrl = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
