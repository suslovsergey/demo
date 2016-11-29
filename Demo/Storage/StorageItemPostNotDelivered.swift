
//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import RealmSwift

class StorageItemPostNotDelivered: Object {
    dynamic var name: String = ""
    dynamic var body: String = ""
    dynamic var date: Date = Date()
    dynamic var userPicUrl: String = ""
    dynamic var uuid: String = UUID().uuidString
    dynamic var inQueue: Bool = false

    override static func primaryKey() -> String? {
        return "uuid"
    }

    func convertToItemPost() -> StorageItemPost {
        let obj = StorageItemPost()
        obj.name = self.name
        obj.body = self.body
        obj.date = self.date
        obj.userPicUrl = self.userPicUrl
        
        return obj
    }
}
