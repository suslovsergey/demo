//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import Foundation
import ObjectMapper

final class ObjectMapperTransformStringToDate: TransformType {
    typealias Object = Date
    typealias JSON = String
    
    private let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    init() {
    }

    final func transformFromJSON(_ value: Any?) -> Date? {
        guard  let v = value as? String else {
            return nil
        }

        let df = DateFormatter()
        df.dateFormat = dateFormat
        return df.date(from: v)
    }

    final func transformToJSON(_ value: Date?) -> String? {
        let v = value ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: v)
    }
}
