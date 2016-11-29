//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class NotifyBase: Mappable {
    required init?(map: Map) {
    }

    init() {

    }

    func mapping(map: Map) {
    }
}


class Notify {
    static private var observers: [Observer] = []

    class Observer {
        private var targetClass: String!
        private var observer: Any? = nil

        init(_ target: Any) {
            self.targetClass = String(describing: type(of: target))
        }

        func observe<T:NotifyBase>(_ cls: T.Type, callBack: @escaping (T?) -> Void) {
            self.observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: NSStringFromClass(cls)),
                    object: nil,
                    queue: OperationQueue.main,
                    using: {
                        if let ui = $0.userInfo {
                            callBack(Mapper<T>().map(JSONObject: ui))
                        }
                    })

            Notify.observers.append(self)
        }

        func stopObserve() {
            Notify.observers = Notify.observers.flatMap {
                guard $0.targetClass == self.targetClass else {
                    return $0
                }

                NotificationCenter.default.removeObserver($0)
                return nil
            }
        }
    }

    class func target(_ target: Any) -> Observer {
        return Observer(target)
    }

    class func send<T:NotifyBase>(_ cls: T.Type, setup: ((T) -> Void)? = nil) {

        if let obj = Mapper<T>().map(JSONString: "{}") {
            setup?(obj)

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NSStringFromClass(cls)),
                    object: nil,
                    userInfo: (obj as Mappable).toJSON())

        }
        else {

        }
    }
}