//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit

enum MyError: Error {
    case apiClientNoStatusCode
    case apiClientDataIsNotJSON
    case apiClientUnknownStatusCode
    case modelPostsUndeliveredPostNoResults
    case apiClientDataIsNotImage
}