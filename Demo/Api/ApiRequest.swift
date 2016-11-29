//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiRequest: Mappable {
    required init?(map: Map) {
        super.init?(map: map)
    }

    func mapping(map: Map) {
        super.mapping(map: map)
    }
}