//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import RealmSwift

class StorageItemPost: Object {
    dynamic var id: Int64 = 0
    dynamic var name: String = ""
    dynamic var body: String = ""
    dynamic var date: Date = Date()
    dynamic var userPicUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
