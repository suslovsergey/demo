//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import Alamofire

class ApiClientOptions<T> {
    var result: T?
    var statusCode: Int = 200
    var error: NSError?

    var method = Alamofire.HTTPMethod.get
    var url = ""
    var parameters: [String: Any] = [:]

    var response: DataResponse<Any>?

    init() {
        result = nil
        url = ""
        method = .get
    }

    convenience init(url: String, method: Alamofire.HTTPMethod = .get) {
        self.init()
        self.url = url
        self.method = method
    }
}
