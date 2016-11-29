//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiRequestPost: ApiRequest {
    var name = ""
    var body = ""
    var userPicUrl = ""
    var date = Date()

    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        body <- map["body"]
        userPicUrl <- map["user_pic_url"]
        date <- (map["date"], ObjectMapperTransformStringToDate())
    }
}
