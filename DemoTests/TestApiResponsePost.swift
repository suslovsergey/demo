//
//  TestApiResponsePost.swift
//  Demo
//
//  Created by Sergey Suslov on 27.11.16.
//  Copyright © 2016 SS. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import Demo
class TestApiResponsePost: XCTestCase {
    let oneItem: [String : Any] = [
        "id": UInt(123), //ObjectMapper bug
        "name" : "TestName",
        "body": "SomeText",
        "user_pic_url": "SomeUrl",
        "date": "2016-01-01T00:00:00.000+00:00"]
    
    func testEmpty() {
        let o = Mapper<ApiResponsePostWrapper>().map(JSON: ["data": []])
        XCTAssertNotNil(o)
        XCTAssertEqual(o!.data.count, 0)
    }
    
    
    func testNonEmpty() {
        let o = Mapper<ApiResponsePostWrapper>().map(JSON: ["data": [oneItem]])
        XCTAssertNotNil(o)
        XCTAssertGreaterThan(o!.data.count, 0)
    }
    
    func testOneItem() {
        let o = Mapper<ApiResponsePost>().map(JSON: oneItem)
        
        XCTAssertNotNil(o)
        XCTAssertEqual(o!.id, 123)
        XCTAssertEqual(o!.name, "TestName")
        XCTAssertEqual(o!.body, "SomeText")
        XCTAssertEqual(o!.userPicUrl, "SomeUrl")
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let d = df.date(from: "2016-01-01 00:00:00")
        XCTAssertNotNil(d)
        XCTAssertEqual(o!.date, d!)
        
    }
    
}
