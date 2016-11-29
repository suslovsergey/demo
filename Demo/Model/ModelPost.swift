//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import PromiseKit

class ModelPost {

    static private let undeliveredPostsQueue = DispatchQueue(label: "ModelPost.undelivered")

    class func get() -> Promise<[StorageItemPost]> {
        return ApiClient.posts().then { (r) -> [StorageItemPost] in
            guard let result = r.result else {
                return []
            }
            ModelStorage.posts(save: result.data)
            Notify.send(NotifyUpdatePosts.self)
            return ModelStorage.posts()
        }
    }

    class func post(_ body: String, name: String, userPicUrl: String) {
        let storageObject = StorageItemPostNotDelivered()
        storageObject.body = body
        storageObject.name = name
        storageObject.userPicUrl = userPicUrl

        ModelStorage.undeliveredPosts(add: storageObject)
        Notify.send(NotifyUpdatePosts.self)
        ModelPost.postSendUndelivered()
    }

    class func postSendUndelivered() {
        ModelStorage.undeliveredPosts().forEach { (object) in
                        let request = self.convert(apiRequestPost: object)
                        ModelStorage.undeliveredPosts(inQueue: object, status: true)
                        undeliveredPostsQueue.async {
                            Notify.send(NotifyUploadNotDeliveredPostsStart.self)
                            ApiClient.post(request)
                                     .then { r -> Void in

                                         guard let result = r.result else {
                                             throw(MyError.modelPostsUndeliveredPostNoResults)
                                         }
                                         ModelStorage.undeliveredPosts(delete: object)
                                         ModelStorage.posts(save: result)
                                     }
                                     .always {
                                         Notify.send(NotifyUploadNotDeliveredPostsStop.self)
                                     }
                                     .catch {
                                         Log.error($0)
                                         ModelStorage.undeliveredPosts(inQueue: object, status: false)
                                     }
                        }
                    }
    }


    class func convert(apiRequestPost object: StorageItemPostNotDelivered) -> ApiRequestPost {
        let request = ApiRequestPost()
        request.name = object.name
        request.body = object.body
        request.date = object.date
        request.userPicUrl = object.userPicUrl
        return request
    }


}
