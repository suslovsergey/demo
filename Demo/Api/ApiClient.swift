//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import Log
import AlamofireImage

class ApiClient {
    static let sharedInstance = ApiClient()
    static let images = AutoPurgingImageCache()
    private let url = "https://infotech-test.herokuapp.com"
    lazy private var mgr: Alamofire.SessionManager = {
        let cfg = URLSessionConfiguration.default
        cfg.timeoutIntervalForRequest = 60.0
        cfg.timeoutIntervalForResource = 60.0
        cfg.httpCookieAcceptPolicy = .never
        cfg.httpShouldSetCookies = false
        return Alamofire.SessionManager(configuration: cfg)
    }()

    private var defaultHeaders: [String: String] = [
            "Content-Type": "application/json; charset=utf-8"
    ]

    func request<T:Mappable>(_ options: ApiClientOptions<T>) -> Promise<ApiClientOptions<T>> {
        options.url = url + options.url
        return Promise<ApiClientOptions<T>> {
            (fulfill, reject) -> Void in
            return self.runRequest(options, fulfill: fulfill, reject: reject)
        }
    }

    private func runRequest<T:Mappable>(_ options: ApiClientOptions<T>,
                                        fulfill: @escaping (ApiClientOptions<T>) -> Void,
                                        reject: @escaping (Error) -> Void) {

        mgr.request(options.url,
                           method: options.method,
                           parameters: options.parameters,
                           encoding: (options.method == .post) ? Alamofire.JSONEncoding.default : Alamofire.URLEncoding.default)
                   .responseJSON {
                       response in

                       if let error = response.result.error {
                           reject(error)
                           return
                       }

                       guard let statusCode = response.response?.statusCode else {
                           reject(MyError.apiClientNoStatusCode)
                           return
                       }

                       guard var jsonData = response.result.value else {
                           reject(MyError.apiClientDataIsNotJSON)
                           return
                       }

                       options.response = response

                       switch (statusCode) {
                       case 200, 201:
                           if let _ = jsonData as? [Any] {
                               jsonData = ["data": jsonData]
                           }

                           options.result = Mapper<T>().map(JSONObject: jsonData)

                           fulfill(options)
                       default:
                           reject(MyError.apiClientUnknownStatusCode)
                           break
                       }
                   }
    }

    class func image(_ url: String) -> Promise<UIImage> {
        return Promise<UIImage> { (f, r) -> Void in
            if let img = images.image(withIdentifier: url) {
                f(img)
                return
            }

            Alamofire.request(url).responseImage { response in
                         if let image = response.result.value {
                             images.add(image, withIdentifier: url)
                             f(image)
                             return
                         }

                             r(MyError.apiClientDataIsNotImage)
                     }
        }
    }
}

