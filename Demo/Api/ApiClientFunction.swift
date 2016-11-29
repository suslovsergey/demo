//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import PromiseKit

extension ApiClient {
    class func posts() -> Promise<ApiClientOptions<ApiResponsePostWrapper>>{
        let options = ApiClientOptions<ApiResponsePostWrapper>(url: "/")
        return ApiClient.sharedInstance.request(options)
    }

    class func post(_ request: ApiRequestPost) -> Promise<ApiClientOptions<ApiResponsePost>> {
        let options = ApiClientOptions<ApiResponsePost>(url: "/post")
        options.parameters = request.toJSON()
        options.method = .post
        return ApiClient.sharedInstance.request(options)
    }
}
