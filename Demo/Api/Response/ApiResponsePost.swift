//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiResponsePostWrapper: ApiResponse {
    var data: [ApiResponsePost] = []
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class ApiResponsePost: ApiResponse {
    var id: UInt = 0
    var name = ""
    var body = ""
    var userPicUrl = ""
    var date = Date()

    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        name <- map["name"]
        body <- map["body"]
        userPicUrl <- map["user_pic_url"]
        date <- (map["date"], ObjectMapperTransformStringToDate())
    }
}
