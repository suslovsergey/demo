//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import RealmSwift

class ModelStorage {
    class func posts() -> [StorageItemPost] {
        let realm = try! Realm()
        return (Array(realm.objects(StorageItemPostNotDelivered.self)
                           .sorted(byProperty: "date", ascending: false))
                .flatMap {
                    $0.convertToItemPost()
                })
                + Array(realm.objects(StorageItemPost.self).sorted(byProperty: "date", ascending: false))
    }

    class func posts(save objects: [ApiResponsePost]) {
        let postsIdx = self.posts().flatMap {
            UInt($0.id)
        }
        objects
                .filter({ !postsIdx.contains($0.id) })
                .forEach {
                    self.posts(save: $0)
                }
    }

    class func posts(save object: ApiResponsePost) {
        self.posts(save: self.convert(storageItemPost: object))
    }

    class func posts(save object: StorageItemPost) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: true)
        }
    }

    class func undeliveredPosts2() -> Results<StorageItemPostNotDelivered> {
        let realm = try! Realm()
        return  realm.objects(StorageItemPostNotDelivered.self)
                     .filter("inQueue == false")
                     .sorted(byProperty: "date", ascending: true)
    }

    class func undeliveredPosts() -> [StorageItemPostNotDelivered] {
        let realm = try! Realm()
        return Array(realm.objects(StorageItemPostNotDelivered.self)
                          .filter("inQueue == false")
                          .sorted(byProperty: "date", ascending: true))
    }

    class func undeliveredPosts(delete object: StorageItemPostNotDelivered) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }

    class func undeliveredPosts(add object: StorageItemPostNotDelivered) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
    }

    class func undeliveredPosts(inQueue object: StorageItemPostNotDelivered, status: Bool) {
        let realm = try! Realm()
        try! realm.write {
            object.inQueue = status
        }
    }

    class func user() -> StorageItemUser {
        let realm = try! Realm()
        guard let u = realm.objects(StorageItemUser.self).first else  {
            let obj = StorageItemUser()
            try! realm.write {
                realm.add(obj)
            }
            return obj
        }

        return u
    }
    
    class func userUpdate(_ name: String, picUrl: String) {
        let realm = try! Realm()
        let u = self.user()
        try! realm.write {
            u.name = name
            u.picUrl = picUrl
        }
    }

    // Convert Part

    class func convert(storageItemPost from: ApiResponsePost) -> StorageItemPost {
        let to = StorageItemPost()
        to.id = Int64(from.id)
        to.name = from.name
        to.body = from.body
        to.date = from.date
        to.userPicUrl = from.userPicUrl
        return to
    }

    class func convert(storageItemPostNotDelivered from: ApiResponsePost) -> StorageItemPostNotDelivered {
        let to = StorageItemPostNotDelivered()
        to.name = from.name
        to.body = from.body
        to.date = from.date
        to.userPicUrl = from.userPicUrl
        return to
    }

    class func convert(storageItemPostNotDelivered from: ApiRequestPost) -> StorageItemPostNotDelivered {
        let to = StorageItemPostNotDelivered()
        to.name = from.name
        to.body = from.body
        to.date = from.date
        to.userPicUrl = from.userPicUrl
        return to
    }
}
